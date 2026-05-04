FROM php:8.2-apache

# Install extensions
RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip curl \
    libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install mysqli pdo pdo_mysql gd zip \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

# Copy all files first
COPY . .

# Copy and enable custom Apache config
COPY 000-default.conf /etc/apache2/sites-available/

# Setup Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    echo "Listen 8080" > /etc/apache2/ports.conf && \
    a2ensite 000-default.conf && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

EXPOSE 8080

CMD ["apache2-foreground"]
