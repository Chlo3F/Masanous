<?php 
namespace App\Service;

use Symfony\Contracts\HttpClient\HttpClientInterface;

class RecaptchaService
{
    private string $secretKey;
    private HttpClientInterface $client;

    public function __construct(HttpClientInterface $client, string $recaptchaSecretKey)
    {
        $this->client = $client;
        $this->secretKey = $recaptchaSecretKey;
    }

    public function verify(string $token): bool
    {
        $response = $this->client->request('POST', 'https://www.google.com/recaptcha/api/siteverify', [
            'body' => [
                'secret' => $this->secretKey,
                'response' => $token
            ]
        ]);

        $result = $response->toArray();
        return $result['success'] && $result['score'] > 0.5;
    }
}

