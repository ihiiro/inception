#!/bin/bash

set -e

echo "Setting up MariaDB..."

DB_INIT_SQL=/etc/mysql/init.sql
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" > $DB_INIT_SQL
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';" >> $DB_INIT_SQL
echo "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS' WITH GRANT OPTION;" >> $DB_INIT_SQL
echo "FLUSH PRIVILEGES;" >> $DB_INIT_SQL
sleep 5
mysql_install_db

exec mysqld