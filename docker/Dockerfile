ARG PHP_VERSION=7.4.30
FROM php:${PHP_VERSION}-apache
MAINTAINER Andrew Alba <aalba@metabolicliving.com>

RUN set -ex; \
    \
    apt-get update; \
    apt-get install -y \
    libzip-dev \
    zip \
    libpng-dev \
    zlib1g-dev \
    libjpeg-dev \
    libfreetype6-dev \
;

RUN docker-php-ext-install mysqli &&  \
    docker-php-ext-enable mysqli && \
    docker-php-ext-install zip ;

# GD install
RUN docker-php-ext-configure gd --with-freetype --with-jpeg;

RUN docker-php-ext-install gd ;

# Install xDebug
ENV XDEBUG_VERSION=3.1.4
RUN pecl install xdebug-${XDEBUG_VERSION} && \
    docker-php-ext-enable xdebug ;

# Copy xdebug configration for remote debugging
COPY xdebug-${XDEBUG_VERSION}.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN rm -rf /var/lib/apt/lists/*

# set additional PHP.ini settings
RUN { \
    echo 'memory_limit=1024M'; \
    echo 'mysqli.reconnect=1'; \
    } > /usr/local/etc/php/conf.d/zzz_custom_php_options.ini;

# create folders
RUN chown -R www-data:www-data /var/www/html
RUN mkdir -p /var/www/storage
RUN chown -R www-data:www-data /var/www/storage

# add certs
ADD ./certs /etc/ssl/certs

# Apache Instructions
COPY vhost-config /etc/apache2/sites-enabled/000-default.conf
RUN ln -s /etc/apache2/mods-available/ssl.load  /etc/apache2/mods-enabled/ssl.load
RUN a2enmod rewrite expires headers
RUN a2enmod ssl

# EXPOSE 80
EXPOSE 443

RUN service apache2 restart

CMD ["apache2-foreground"]