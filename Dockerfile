FROM php:8.2-cli

RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev libicu-dev libxml2-dev libonig-dev git unzip curl

RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

WORKDIR /var/www/html

COPY . .

RUN chown -R www-data:www-data /var/www/html

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN composer install

EXPOSE 9001

CMD ["php", "-S", "0.0.0.0:80", "-t", "public", "php-fpm"]
