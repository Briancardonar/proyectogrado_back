FROM php:8.1.0-fpm as base
ARG user
ARG uid
# Install system dependencies
RUN apt-get update && apt-get install -y curl libpng-dev libonig-dev libxml2-dev unzip libzip-dev libmagickwand-dev
RUN pecl install imagick
# Install PHP extensions
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install zip && docker-php-ext-enable imagick
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install -j$(nproc) gd
# optimizacion de php
RUN docker-php-ext-configure opcache --enable-opcache && docker-php-ext-install opcache
# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN apt-get autoclean
RUN apt-get autoremove
# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && chown -R $user:$user /home/$user

FROM base as develop
RUN chown -R $user:$user /var/www
RUN chown -R www-data:www-data /var/www
RUN chmod -R 775 /var/www
# Set working directory
WORKDIR /var/www
COPY . .
USER $user
RUN composer install

FROM base as debug
RUN pecl install xdebug && docker-php-ext-enable xdebug

FROM base as testing
RUN chown -R $user:$user /var/www
RUN chmod -R 775 /var/www
# Set working directory
WORKDIR /var/www
COPY . .
USER $user
