FROM php:8.3-fpm

RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl unzip zip \
    libpq-dev libzip-dev libicu-dev libonig-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) \
        pdo pdo_pgsql pgsql mbstring intl zip opcache

RUN pecl install redis && docker-php-ext-enable redis

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Nu copia nimic la build ca sa mearga si pe folder gol.
CMD ["php-fpm"]
