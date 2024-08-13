FROM php:8.0-cli

RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev libicu-dev libxml2-dev libonig-dev git unzip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN useradd -ms /bin/sh myuser
USER myuser

COPY . /var/www/html

WORKDIR /var/www/html

RUN composer install

EXPOSE 80
