#!/bin/bash

docker run -d --network mynet --name erpdb --env MARIADB_ROOT_PASSWORD=54321 erpdb:14
docker run -it -d --privileged --network mynet --name erp -p 8000:8000 -p 9000:9000 -p3306:3306 erpnext:14

docker cp /home/vicky/Webapp/site-init.sh erp:/home/frappe/
docker exec -it erp ./site-init.sh
