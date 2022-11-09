FROM composer:2 AS composer
FROM php:8.1-fpm
COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN mkdir -p /var/www/html
WORKDIR /var/www/html

RUN apt update \
    && apt install -y zlib1g-dev g++ git libicu-dev zip libzip-dev zip \
    && docker-php-ext-install intl opcache pdo pdo_mysql \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \