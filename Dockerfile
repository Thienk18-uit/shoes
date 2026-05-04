FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    libzip-dev zip curl \
    libpng-dev libjpeg-dev libfreetype6-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install mysqli gd zip && \
    a2enmod rewrite && \
    rm -rf /var/lib/apt/lists/*

RUN sed -i 's/Listen 80/Listen 8080/g' /etc/apache2/ports.conf

WORKDIR /var/www/html
COPY . .

RUN chown -R www-data:www-data . && chmod -R 755 .

EXPOSE 8080
CMD ["apache2-foreground"]
