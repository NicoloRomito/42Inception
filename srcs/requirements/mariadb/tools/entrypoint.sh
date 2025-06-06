#!/bin/sh

print_info() {
    echo -e "\e[34m[INFO]\e[0m $1"
}

print_info "Running mysql installDB"

mysql_install_db --user=mysql --datadir=/var/lib/mysql

# service mysql start
print_info "Running mysqld_safe ";

mysqld_safe --user=mysql --datadir=/var/lib/mysql &
sleep 5
print_info "Installed mysql";

# until mysqladmin ping --silent; do
#     print_info "Waiting for MariaDB to start..."
#     sleep 2
# done

print_info "MariaDB started"

mariadb -u root -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mariadb -u root -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
mariadb -u root -e "FLUSH PRIVILEGES;"

print_info "SHUtting down";
mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown

print_info "relaunching";
exec mysqld_safe --user=mysql --datadir=/var/lib/mysql

# mysql < db1.sql

# kill $(cat /var/run/mysqld/mysqld.pid)

# mysqld