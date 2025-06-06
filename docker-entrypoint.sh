#!/bin/sh
set -e

# Fix permissions for folders mounted from host
chown -R www-data:www-data /var/www/html/runtime /var/www/html/web/assets
chmod -R 775 /var/www/html/runtime /var/www/html/web/assets

# Start Apache
exec apache2-foreground
