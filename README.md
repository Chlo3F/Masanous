# 📬 Contact OnePage Symfony

Une application Symfony simple, déployable via Docker, avec une page de contact et un formulaire (sans base de données).

---

## 🚀 Fonctionnalités

- Page unique avec un formulaire de contact
- Validation front (JS) et back (Symfony)
- Aucune base de données requise
- Dockerisé (PHP + NGINX)

---

## 🐳 Lancer le projet avec Docker

### ✅ Prérequis

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/) installé

### 📦 Installation

Clonez le projet :

```bash
git clone https://github.com/<ton-utilisateur>/<ton-repo>.git
cd <ton-repo>

### **Lancer les conteneurs**
docker-compose up --build

** L'application sera disponible sur : **

>>>> http://localhost:8080

** 📦 Déploiement (Render.com) **
Si tu utilises Render.com, un fichier render.yaml est fourni pour déployer directement le projet via Docker.
