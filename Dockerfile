FROM php:8.3-fpm AS php_fpm


FROM php_fpm AS php_fpm_base

# Installing tools & libraries
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install --fix-missing git unzip pkg-config \
    libcurl4-openssl-dev libssl-dev libxml2-dev

# Installing PHP extensions
RUN docker-php-ext-install opcache intl pcntl pdo_mysql

ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="0"
ADD docker/php/opcache.ini "$PHP_INI_DIR/conf.d/opcache.ini"

# Installing Composer
RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/local/bin --filename=composer

ENV COMPOSER_ALLOW_SUPERUSER=1

# Installing Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash && \
    mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

# Cleanup after install
RUN docker-php-source delete \
    && apt-get -y autoremove --purge \
    && apt-get -y autoclean \
    && apt-get -y clean

WORKDIR /var/www/html
COPY ./ ./
RUN chown -R www-data:www-data *

EXPOSE 9000

CMD ${COMMAND}

FROM php_fpm_base as php_fpm_dev

RUN pecl install xdebug && docker-php-ext-enable xdebug

FROM php_fpm_base AS php_fpm_prod


