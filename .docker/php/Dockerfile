FROM composer:2 AS composer
FROM php:8-fpm-alpine
COPY --from=composer /usr/bin/composer /usr/bin/composer

ARG UID
ARG GID

ENV UID=${UID}
ENV GID=${GID}

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

# MacOS staff group's gid is 20, so is the dialout group in alpine linux. We're not using it, let's just remove it.
RUN delgroup dialout

RUN addgroup -g ${GID} --system cristian
RUN adduser -G cristian --system -D -s /bin/sh -u ${UID} cristian

RUN sed -i "s/user = www-data/user = cristian/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = cristian/g" /usr/local/etc/php-fpm.d/www.conf
RUN echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.d/www.conf

RUN docker-php-ext-install pdo pdo_mysql

RUN mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/5.3.4.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts \
    && docker-php-ext-install redis