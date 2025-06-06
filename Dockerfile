FROM php:8.1-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Enable Apache modules
RUN a2enmod rewrite

# Set ServerName globally to suppress FQDN warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY ./app /var/www/html/

# Set ownership
RUN chown -R www-data:www-data /var/www/html

# Install Composer dependencies
RUN composer install  --optimize-autoloader

# Set permissions
RUN chmod -R 775 /var/www/html/runtime /var/www/html/web/assets
RUN chown -R www-data:www-data /var/www/html/runtime /var/www/html/web/assets

# Configure Apache for Yii2
RUN echo '<VirtualHost *:80> \n\
    DocumentRoot /var/www/html/web \n\
    <Directory /var/www/html/web> \n\
        RewriteEngine on \n\
        RewriteCond %{REQUEST_FILENAME} !-f \n\
        RewriteCond %{REQUEST_FILENAME} !-d \n\
        RewriteRule . index.php \n\
        AllowOverride All \n\
        Require all granted \n\
    </Directory> \n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

EXPOSE 80

# Copy custom entrypoint
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
