FROM php:8.4-fpm

RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libpq-dev \
    libxml2-dev \
    && docker-php-ext-install pdo pdo_pgsql

COPY --from=composer:2.8 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/app

COPY composer.json composer.lock ./

RUN composer install --no-interaction --prefer-dist --no-scripts

COPY . .

RUN composer install --no-interaction --prefer-dist --optimize-autoloader

EXPOSE 9000

CMD ["php-fpm"]
