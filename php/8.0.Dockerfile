FROM php:8.0-fpm

RUN apt-get update && apt-get install -y git zip nano

RUN curl --silent --show-error https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN docker-php-ext-install bcmath && docker-php-ext-enable bcmath
RUN docker-php-ext-install pdo && docker-php-ext-enable pdo
RUN docker-php-ext-install pdo_mysql && docker-php-ext-enable pdo_mysql
# RUN docker-php-ext-install pdo_sqlite && docker-php-ext-enable pdo_sqlite
RUN docker-php-ext-install dba && docker-php-ext-enable dba

RUN apt-get update && apt-get install -y libcurl4-openssl-dev && docker-php-ext-install curl && docker-php-ext-enable curl

RUN apt-get update && apt-get install -y libwebp-dev libjpeg62-turbo-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev
RUN docker-php-ext-configure gd --with-freetype --with-jpeg=/usr/include/
RUN docker-php-ext-install gd && docker-php-ext-enable gd

RUN apt-get update && apt-get install -y libzip-dev && docker-php-ext-install zip && docker-php-ext-enable zip

# RUN docker-php-ext-install json && docker-php-ext-enable json
# RUN docker-php-ext-install hash && docker-php-ext-enable hash
RUN docker-php-ext-install opcache && docker-php-ext-enable opcache

RUN docker-php-ext-install exif && docker-php-ext-enable exif

RUN pecl install xdebug && docker-php-ext-enable xdebug

RUN apt-get update && apt-get install -y libssh2-1-dev

RUN pecl install ssh2-1.3.1 && docker-php-ext-enable ssh2

EXPOSE 8000
