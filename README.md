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

---

## ☁️ Déploiement sur Render

Ce projet est déployable gratuitement sur [Render.com](https://render.com/).

### Étapes :

1. Créer un compte sur [Render](https://render.com/)
2. Créer un "New Web Service"
3. Choisir :
   - **Type** : Web Service
   - **Environment** : Docker
   - **Dockerfile** : `Dockerfile` à la racine
   - **Branch** : `main`

> ✅ Le fichier `render.yaml` est déjà prêt.


