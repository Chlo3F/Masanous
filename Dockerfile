# Dockerfile

FROM php:8.2-fpm-alpine

# Installer dépendances système et PHP CLI
RUN apk add --no-cache \
    nginx \
    bash \
    curl \
    libzip-dev \
    zip \
    libpng-dev \
    icu-dev \
    oniguruma-dev \
    php8-cli \
    && docker-php-ext-install pdo pdo_mysql intl opcache mbstring zip

# Installer Composer globalement
RUN curl -sS https://getcomposer.org/installer \
    | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer

# Vérifier la version de Composer (utile pour debug build)
RUN composer --version

# Copier le fichier php.ini personnalisé
COPY ./docker/php/php.ini /usr/local/etc/php/php.ini

# Créer utilisateur pour Symfony
RUN adduser -D symfony

# Créer les dossiers nécessaires et copier le code
RUN mkdir -p /var/www/symfony /run/nginx
COPY . /var/www/symfony

# Définir le répertoire de travail
WORKDIR /var/www/symfony

# Installer les dépendances PHP via Composer
RUN composer install --no-interaction --no-dev --optimize-autoloader

# Copier la config nginx
COPY ./docker/nginx/default.conf /etc/nginx/http.d/default.conf

# Exposer le port 80
EXPOSE 80

# Commande de démarrage : PHP-FPM + Nginx
CMD ["/bin/sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]
