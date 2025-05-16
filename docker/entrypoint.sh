#!/bin/sh
set -e

# Nettoyage et cache
php bin/console cache:clear

# Installation des assets (optionnel)
php bin/console assets:install public

# Importmap si utilisé (Symfony UX)
php bin/console importmap:install

# Lancer les services
php-fpm -D
nginx -g "daemon off;"
