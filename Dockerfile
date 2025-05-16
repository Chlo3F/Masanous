# Dockerfile

FROM php:8.2-fpm-alpine

# Install dependencies
RUN apk add --no-cache nginx bash curl libzip-dev zip libpng-dev icu-dev oniguruma-dev \
    && docker-php-ext-install pdo pdo_mysql intl opcache mbstring zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Configure PHP
COPY ./docker/php/php.ini /usr/local/etc/php/php.ini

# Create user for Symfony
RUN adduser -D symfony

# Create necessary directories
RUN mkdir -p /var/www/symfony /run/nginx
COPY . /var/www/symfony
WORKDIR /var/www/symfony

# Install vendor dependencies
RUN composer install --no-interaction --no-dev --optimize-autoloader

# NGINX configuration
COPY ./docker/nginx/default.conf /etc/nginx/http.d/default.conf

# Expose port 80
EXPOSE 80

# Entrypoint script to launch both PHP-FPM and NGINX
CMD ["/bin/sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]
