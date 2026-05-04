FROM php:8.2-apache

# Install required extensions
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libzip-dev zip unzip curl \
        libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install mysqli pdo pdo_mysql gd \
    && a2enmod rewrite headers \
    && rm -rf /var/lib/apt/lists/*

# Set up Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

WORKDIR /var/www/html

COPY . /var/www/html

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

EXPOSE 80

CMD ["apache2-foreground"]
