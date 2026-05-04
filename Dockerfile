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

# Configure Apache to listen on PORT environment variable or default 8080
RUN sed -i 's/Listen 80/Listen ${PORT:-8080}/g' /etc/apache2/ports.conf

WORKDIR /var/www/html

COPY . /var/www/html

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

EXPOSE 8080

# Start Apache with port substitution
CMD ["sh", "-c", "sed -i \"s/Listen 8080/Listen ${PORT:-8080}/g\" /etc/apache2/ports.conf && apache2-foreground"]
