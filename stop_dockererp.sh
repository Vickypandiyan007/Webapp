!# /bin/bash

docker stop erpnext mariadb
docker rm erpnext mariadb
docker network rm erpnet

docker ps -a
docker network ls
