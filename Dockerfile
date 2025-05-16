# Base PHP avec FPM (Alpine pour taille réduite)
FROM php:8.2-fpm-alpine

# Installer dépendances système nécessaires (nginx, curl, bash, extensions PHP, etc.)
RUN apk add --no-cache \
    nginx \
    bash \
    curl \
    libzip-dev \
    zip \
    libpng-dev \
    icu-dev \
    oniguruma-dev \
    mysql-client \
    gcc \
    g++ \
    make \
    autoconf \
    && docker-php-ext-install pdo pdo_mysql intl opcache mbstring zip

# Installer Composer (avec chmod +x et ajout PATH)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer

ENV PATH="/usr/local/bin:${PATH}"

# Vérification de Composer (optionnel, tu peux commenter après test)
RUN composer --version

# Copier le php.ini personnalisé (à ajuster selon ton projet)
COPY ./docker/php/php.ini /usr/local/etc/php/php.ini

# Copier la config nginx personnalisée
COPY ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf

# Créer un utilisateur non-root pour la sécurité
RUN adduser -D symfony

# Copier le projet dans le dossier de travail
WORKDIR /var/www/symfony
COPY . .

# Installer les dépendances PHP (sans interaction et sans dev)
RUN composer install --no-interaction --no-dev --optimize-autoloader

# Exposer le port HTTP
EXPOSE 80

# Lancer php-fpm en daemon puis nginx en foreground
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]
