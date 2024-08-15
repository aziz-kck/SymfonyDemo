
FROM php:8.2-fpm

# Installer les dépendances PHP
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libicu-dev libxml2-dev libonig-dev git unzip curl \
    && docker-php-ext-install gd intl pdo_mysql

# Installer Node.js et npm
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs

# Installer Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash \
    && mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

# Copier Composer depuis une image existante
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

WORKDIR /var/www/html

# Copier le code source
COPY . .

# Changer les permissions
RUN chown -R www-data:www-data /var/www/html

ENV COMPOSER_ALLOW_SUPERUSER=1

# Installer les dépendances PHP
RUN composer update

# Installer les dépendances npm (si nécessaire pour Sass)
RUN npm install

EXPOSE 9000

CMD ["php-fpm"]

