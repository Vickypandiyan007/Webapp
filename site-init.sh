#!/bin/bash

cd ~/frappe-bench
bench new-site agnikul.net --admin-password Agnikul321 --mariadb-root-username root --mariadb-root-password 54321 --db-host erpdb
sleep 5
bench --site agnikul.net install-app erpnext
sleep 5
bench use agnikul.net
sleep 3

sudo sysctl vm.overcommit_memory=1
sudo echo madvise > /sys/kernel/mm/transparent_hugepage/enabled

echo "Starting a bench..."
bench start

#if [ $?=0 ]; then
#	echo "Bench Started successfully"

