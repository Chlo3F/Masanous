FROM php:8.2-fpm-alpine

# Installer dépendances système et outils nécessaires
RUN apk add --no-cache \
    bash \
    curl \
    libzip-dev \
    zip \
    libpng-dev \
    icu-dev \
    oniguruma-dev \
    nginx \
    mysql-client \
    mysql-dev \
    gcc \
    g++ \
    make \
    autoconf

# Installer extensions PHP
RUN docker-php-ext-install pdo pdo_mysql intl opcache mbstring zip

# Installer Composer
RUN curl -sS https://getcomposer.org/installer \
    | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer

# Copier php.ini personnalisé
COPY ./docker/php/php.ini /usr/local/etc/php/php.ini

# Copier configuration Nginx personnalisée
COPY ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf


# Créer utilisateur Symfony
RUN adduser -D symfony

# Copier le code source
WORKDIR /var/www/symfony
COPY . .

# Installer dépendances PHP
RUN composer install --no-interaction --no-dev --optimize-autoloader

# Exposer port 80 (HTTP)
EXPOSE 80

# Commande pour lancer PHP-FPM et Nginx ensemble
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]

