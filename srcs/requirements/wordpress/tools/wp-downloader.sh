#!/bin/bash

cd /var/www/html
set -e


echo "Waiting for MySQL to be ready..."

while ! mysqladmin ping -h"$DATABASE_HOST" -u"$DATABASE_USER" -p"$DATABASE_PASSWORD" --silent; do
    echo "MySQL is not ready yet..."
  sleep 1
done

echo "MySQL is ready!"

#Check if Wordpress is already installed

if [ ! -f wp-config.php ]; then
    # Download and install WordPress
    echo "WordPress is not installed. Proceeding with installation..."
  if ! wp core download --allow-root; then
    echo "Failed to download WordPress."
    exit 1
  fi
  if ! wp config create --dbname="$DATABASE_NAME" --dbuser="$DATABASE_USER" --dbpass="$DATABASE_PASSWORD" --dbhost="$DATABASE_HOST" --allow-root; then
    echo "Failed to create WordPress config."
    exit 1
  fi
  if ! wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN" --admin_password="$WP_ADMIN_PASS" --admin_email="$WP_ADMIN_MAIL" --allow-root; then
    echo "Failed to install WordPress."
    exit 1
  fi
  echo "WordPress installation completed successfully."

else
  echo "WordPress is already installed."
  if ! wp user create --allow-root $WP_USER_GST $WP_USER_GST_MAIL --role=subscriber --user_pass="$WP_USER_GST_PASS"; then
    echo "Failed to create WordPress user."
    exit 1
  fi
fi

echo "Starting PHP-FPM..."
php-fpm8.1 -F
