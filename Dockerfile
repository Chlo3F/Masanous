FROM php:8.2-fpm-alpine

# Installer les dépendances système nécessaires
RUN apk add --no-cache \
    nginx \
    bash \
    curl \
    libzip-dev \
    zip \
    libpng-dev \
    icu-dev \
    oniguruma-dev \
    git \
    unzip \
    autoconf \
    g++ \
    make \
    && docker-php-ext-install pdo pdo_mysql intl opcache mbstring zip

# Installer Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Créer les répertoires nécessaires
WORKDIR /var/www/symfony

# Copier les fichiers du projet
COPY . .

# Supprimer le cache potentiel et installer les dépendances avec les bons droits
RUN rm -rf vendor/ var/cache/* \
    && composer install --no-interaction --optimize-autoloader

# Copier la configuration nginx
COPY ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf

# Lancer PHP-FPM et nginx via un script d’entrée
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Exposer le port HTTP
EXPOSE 80

# Commande d’entrée : exécute NGINX au premier plan, php-fpm en arrière-plan
CMD ["/entrypoint.sh"]
