FROM php:8.0-cli

RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev libicu-dev libxml2-dev libonig-dev git unzip

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

WORKDIR /var/www/html

COPY . .

RUN chown -R www-data:www-data /var/www/html

RUN composer install

EXPOSE 80

CMD ["php", "-S", "0.0.0.0:80", "-t", "public"]
