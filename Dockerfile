FROM php:8.2-fpm-alpine

# Installer les dépendances système
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
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Env prod
ENV APP_ENV=prod
ENV APP_DEBUG=0

# Copier le projet
WORKDIR /var/www/symfony
COPY . .

# Installer dépendances prod uniquement
RUN composer install --no-dev --no-scripts --no-interaction --optimize-autoloader

# NGINX config
COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf

# Entrypoint
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80
CMD ["/entrypoint.sh"]
