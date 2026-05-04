FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    libzip-dev zip curl \
    libpng-dev libjpeg-dev libfreetype6-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install mysqli gd zip && \
    a2enmod rewrite && \
    rm -rf /var/lib/apt/lists/*

# Create new ports config
RUN echo "Listen 8080" > /etc/apache2/ports.conf && \
    echo "<VirtualHost *:8080>\n  ServerName localhost\n  DocumentRoot /var/www/html\n  <Directory /var/www/html>\n    AllowOverride All\n    Require all granted\n  </Directory>\n</VirtualHost>" > /etc/apache2/sites-available/000-default.conf && \
    a2ensite 000-default.conf

WORKDIR /var/www/html
COPY . .

RUN chown -R www-data:www-data . && chmod -R 755 .

EXPOSE 8080
CMD ["apache2-foreground"]
