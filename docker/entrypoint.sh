#!/bin/sh
set -e

# Symfony cache (env prod implicite grâce à APP_ENV)
php bin/console cache:clear
php bin/console assets:install public
php bin/console importmap:install || true

# Lancer PHP-FPM + Nginx
php-fpm -D
nginx -g "daemon off;"
