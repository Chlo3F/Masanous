FROM php:8.2-fpm-alpine

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

# php.ini
COPY ./docker/php/php.ini /usr/local/etc/php/php.ini

WORKDIR /var/www/symfony

COPY . .

# Fixer les droits
RUN chown -R www-data:www-data /var/www/symfony

# Installer les dépendances (en prod, sans scripts pour éviter erreurs)
RUN composer install --no-interaction --optimize-autoloader --no-dev --no-scripts

# NGINX
COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf

# Entrypoint
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80

CMD ["/entrypoint.sh"]
