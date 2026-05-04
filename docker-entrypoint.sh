#!/bin/bash
set -e

# Set port from environment or default to 8080
PORT=${PORT:-8080}

# Update Apache ports.conf
sed -i "s/Listen 80/Listen ${PORT}/g" /etc/apache2/ports.conf

# Update VirtualHost if needed
sed -i "s/<VirtualHost \*:80>/<VirtualHost *:${PORT}>/g" /etc/apache2/sites-available/*.conf

# Start Apache
exec apache2-foreground
