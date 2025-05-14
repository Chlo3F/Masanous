<?php

namespace App\Service;

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

class MailService
{
    private string $emailUser;
    private string $mdpUser;

    public function __construct(string $emailUser, string $mdpUser)
    {
        $this->emailUser = $emailUser;
        $this->mdpUser = $mdpUser;
    }

    public function sendContactEmail(string $name, string $email, string $phone, string $message): bool
    {
        $mail = new PHPMailer(true);

        try {
            // Config SMTP
            $mail->isSMTP();
            $mail->Host = 'smtp.gmail.com';
            $mail->SMTPAuth = true;
            $mail->Username = $this->emailUser;
            $mail->Password = $this->mdpUser;
            $mail->SMTPSecure = 'tls';
            $mail->Port = 587;

            // Expéditeur
            $mail->setFrom($this->emailUser, 'Formulaire de contact Masanous');

            // Destinataire 
            $mail->addAddress($this->emailUser); 

            // Ajouter un Reply-To pour pouvoir répondre directement à l'expéditeur
            $mail->addReplyTo($email, $name);

            // Échappement des données utilisateur
            $safeName = htmlspecialchars($name, ENT_QUOTES, 'UTF-8');
            $safeEmail = htmlspecialchars($email, ENT_QUOTES, 'UTF-8');
            $safePhone = htmlspecialchars($phone, ENT_QUOTES, 'UTF-8');
            $safeMessage = nl2br(htmlspecialchars($message, ENT_QUOTES, 'UTF-8'));

            // Contenu du message
            $mail->isHTML(true);
            $mail->Subject = 'Nouveau message de contact';
            $mail->Body = "
                <h3>Message de : {$safeName}</h3>
                <p><strong>Email :</strong> {$safeEmail}</p>
                <p><strong>Téléphone :</strong> {$safePhone}</p>
                <p><strong>Message :</strong><br>{$safeMessage}</p>
            ";
            $mail->AltBody = "Message de : {$safeName}\n"
                . "Email : {$safeEmail}\n"
                . "Téléphone : {$safePhone}\n"
                . "Message :\n" . strip_tags($message);

            $mail->send();
            return true;
        } catch (Exception $e) {
            // Enregistrer l'erreur sans l'afficher aux utilisateurs
            error_log("Mailer Error: " . $mail->ErrorInfo);
            return false;
        }
    }
}