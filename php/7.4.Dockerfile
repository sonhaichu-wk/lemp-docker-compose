FROM php:7.4-fpm

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

RUN apt-get update && apt-get install -y zlib1g-dev libpng-dev && docker-php-ext-install gd && docker-php-ext-enable gd

RUN apt-get update && apt-get install -y libzip-dev && docker-php-ext-install zip && docker-php-ext-enable zip

# RUN docker-php-ext-install json && docker-php-ext-enable json
# RUN docker-php-ext-install hash && docker-php-ext-enable hash
RUN docker-php-ext-install opcache && docker-php-ext-enable opcache

RUN pecl install xdebug && docker-php-ext-enable xdebug

EXPOSE 8000
