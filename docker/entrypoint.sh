#!/bin/sh
set -e

echo "==> Démarrage Symfony (environnement $APP_ENV)"

# Recréer le cache et assets si nécessaire
php bin/console cache:clear
php bin/console assets:install public --no-interaction

# Si Symfony UX (optionnel)
if grep -q "importmap" composer.json; then
  php bin/console importmap:install
fi

# Lancer PHP-FPM et NGINX
php-fpm -D
nginx -g "daemon off;"
