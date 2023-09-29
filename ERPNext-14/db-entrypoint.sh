#!/bin/bash

# Start the MariaDB server
/usr/sbin/mysqld &

# Wait for the MariaDB server to start
until mysqladmin ping -h 127.0.0.1 --silent; do
   sleep 1
done

# Allow remote connections for the root user
mysql -u root -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;"

# Stop and restart MariaDB to apply the changes
mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown
exec /usr/sbin/mysqld

