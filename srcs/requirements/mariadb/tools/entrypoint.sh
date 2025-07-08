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

mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"

# ✅ Add this: create the database!
print_info "Creating database $MYSQL_DATABASE"
mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"

mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'localhost';"
mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"


print_info "Shutting down";
mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown

print_info "relaunching";
exec mysqld_safe --user=mysql --datadir=/var/lib/mysql

# mysql < db1.sql

# kill $(cat /var/run/mysqld/mysqld.pid)

# mysqld