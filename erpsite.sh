# Login into the ERPNext Container
#docker exec -it erpnext /bin/bash

# Creating a Newsite with the given Credentials
cd /home/frappe/frappe-bench/ /bin/bash
bench new-site erpsite --admin-password erpteam123 --mariadb-root-username root --db-host mariadb

# Downloading PAYMENTS, HRMS Apps
sudo bench get-app payments
sudo bench get-app hrms

# Installing ERPNEXT, PAYMENTS & HRMS APPs in a Site
bench --site erpsite install-app erpnext
sleep 5
bench --site erpsite install-app payments
sleep 5
bench --site erpsite install-app hrms

cd /home/frappe/frappe-bench/sites && echo erpsite >currentsite.txt
cd /home/frappe/frappe-bench && bench start
