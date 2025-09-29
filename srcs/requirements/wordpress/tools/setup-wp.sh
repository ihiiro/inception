#!/bin/bash
set -e

until mysqladmin ping -h"$DATABASE_HOST" -u"$DATABASE_USER" -p"$DATABASE_PASSWORD"; do
    sleep 1
done

cd /var/www/html
if [ ! -f wp-config.php ]; then
    if ! wp core download --allow-root; then
        exit 1
    fi
    if ! wp config create --dbname="$DATABASE_NAME" --dbuser="$DATABASE_USER" --dbpass="$DATABASE_PASSWORD" --dbhost="$DATABASE_HOST" --allow-root; then
        exit 1
    fi
    if ! wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN" --admin_password="$WP_ADMIN_PASS" --admin_email="$WP_ADMIN_MAIL" --allow-root; then
        exit 1
    fi
    echo "WordPress installation completed successfully."

else
    echo "WordPress is already installed."

    if wp user get "$WP_USER_GST" --allow-root; then
        echo "User '$WP_USER_GST' already exists, skipping creation."
    else
        if ! wp user create --allow-root "$WP_USER_GST" "$WP_USER_GST_MAIL" --role=subscriber --user_pass="$WP_USER_GST_PASS"; then
            exit 1
        fi
    fi
fi

php-fpm8.1 -F
