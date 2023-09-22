FROM mariadb
LABEL Modified by Vignesh Rameshkumar
COPY mariadb.cnf /etc/mysql/conf.d/
EXPOSE 3306
