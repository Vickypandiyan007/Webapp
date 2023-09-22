#!/bin/bash

# Set your Mariadb root Password here
DBPASS="12345"

# Set your ERPNext Site Password here
ERPPASS="54321"

# Set your Sitename here
SITENAME="frappe.net"

# Pulling Docker Images from Dockerhub
docker pull vickypandiyan007/erpnextdb
docker pull vickypandiyan007/erpnext

# Creating Bridge Network and Containers
docker network create erpnet
docker run -d --network erpnet --name mariadb --env MARIADB_ROOT_PASSWORD=$DBPASS vickypandiyan007/erpnextdb
docker run -d --name erpnext --network erpnet -p 8000:8000 -p 9000:9000 -p 3306:3306 vickypandiyan007/erpnext tail -f /dev/null
docker ps -a


# Login into the ERPNext Container
#docker exec -it erpnext /bin/bash

# Creating a Newsite with the given Credentials
#docker exec erpnext cd /home/frappe/frappe-bench/ /bin/bash
#docker exec erpnext bench new-site $SITENAME --admin-password $ERPPASS --mariadb-root-username root --db-host mariadb

# Downloading PAYMENTS, HRMS Apps
#sudo bench get-app payments
#sudo bench get-app hrms

# Installing ERPNEXT, PAYMENTS & HRMS APPs in a Site
##docker exec erpnext bench --site $SITENAME install-app erpnext
#sleep 5
#docker exec erpnext bench --site $SITENAME install-app payments
#sleep 5
#docker exec erpnext bench --site $SITENAME install-app hrms

#docker exec erpnext cd /home/frappe/frappe-bench/sites && echo $SITENAME >currentsite.txt /bin/bash
#docker exec erpnext cd /home/frappe/frappe-bench /bin/bash && bench start

