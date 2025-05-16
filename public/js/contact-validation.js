document.addEventListener("DOMContentLoaded", function () {
   const form = document.getElementById("contactForm");
const inputs = form.querySelectorAll("input, textarea");

function validateInput(input) {
    const id = input.id;
    const value = input.value.trim();
    let errorElement = null;
    let isValid = true;
    let errorMessage = "";
    let successMessage = "✓ Champ valide.";

    // Associer les IDs d'erreurs
    if (id.includes("fullName")) {
        errorElement = document.getElementById("nameError");
        if (value.length === 0) {
            errorMessage = "Nom requis.";
            isValid = false;
        }
    }

    if (id.includes("email")) {
        errorElement = document.getElementById("emailError");
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(value)) {
            errorMessage = "Email invalide.";
            isValid = false;
        }
    }

    if (id.includes("phone")) {
        errorElement = document.getElementById("phoneError");
        const phonePattern = /^[0-9+\s\-]{7,}$/;
        if (!phonePattern.test(value)) {
            errorMessage = "Téléphone invalide.";
            isValid = false;
        }
    }

    if (id.includes("message")) {
        errorElement = document.getElementById("messageError");
        if (value.length < 10) {
            errorMessage = "Message trop court.";
            isValid = false;
        }
    }

    if (errorElement) {
        if (isValid) {
            errorElement.textContent = successMessage; // ✅ Message positif
            errorElement.style.color = "green";
            input.style.borderColor = "green";
        } else {
            errorElement.textContent = errorMessage;
            errorElement.style.color = "red";
            input.style.borderColor = "red";
        }
    }

    return isValid;
}

inputs.forEach(input => {
    input.addEventListener("blur", function () {
        validateInput(input);
    });

    input.addEventListener("input", function () {
        validateInput(input);
    });
});

form.addEventListener("submit", function (event) {
    let allValid = true;

    inputs.forEach(input => {
        if (!validateInput(input)) {
            allValid = false;
        }
    });

    if (!allValid) {
        event.preventDefault();
    }
});

});
