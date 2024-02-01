#!/bin/bash

################################################
# Author: Vignesh Rameshkumar
# Version: 2.0
# This script will install the Self hosted Frappe Bench
################################################

set -eo pipefail #Error Handling

# Prompt the user for ERPNext version choice
echo -e "\033[33mChoose Which ERPNext version to install:\033[0m"
echo -e "\033[33m1. ERPNext v14\033[0m"
echo -e "\033[33m2. ERPNext v15\033[0m"
echo -e "\033[33m3. Exit\033[0m"

read -p "Enter your choice (1/2/3): " choice

case $choice in
  1)
    FRAPPE_VERSION="version-14"
    ;;
  2)
    FRAPPE_VERSION="version-15"
    ;;
  3)
    echo -e "\033[33mBye, Bye..\033[0m"
    exit 0
    ;;
  *)
    echo -e "\033[31mInvalid choice. Please select 1, 2, or 3.\033[0m"
    exit 1
    ;;
esac

read -p "Set the Sitename : " SITENAME
read -s -p "Set the Site Password : " ADMINPASS

echo

# Installing Dependencies
echo -e "\033[33mUpdating & upgrading system..\033[0m"
sudo apt-get update && sudo apt-get upgrade -y
echo

echo -e "\033[33mInstalling git & Python..\033[0m"
sudo apt-get install -y git \
python3-dev \
python3.10-dev \
python3-setuptools \
python3-pip \
python3-distutils \
python3.10-venv \
software-properties-common
echo

echo -e "\033[33mInstalling Mariadb & Redis server..\033[0m"
sudo apt-get install -y mariadb-client \
mariadb-server \
redis-server
echo

echo -e "\033[33mInstalling other dependencies..\033[0m"
sudo apt-get install -y xvfb \
libfontconfig \
wkhtmltopdf \
libmysqlclient-dev \
curl \
vim
echo

echo -e "\033[33mInstalling secure Mysql..\033[0m"
sudo mysql_secure_installation
echo

echo -e "\033[33mChanging the configuration of mysql..\033[0m"
sleep 2

# Changing mysql configuration
echo "[mysqld]
character-set-client-handshake = FALSE
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci

[mysql]
default-character-set = utf8mb4" | sudo tee -a /etc/mysql/my.cnf

echo

echo -e "\033[33mRestarting mysql..\033[0m"
sudo service mysql restart
sleep 2

echo -e "\033[33mInstalling Node, npm & yarn...\033[0m"

curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Node.js 18
nvm install 18

# Use Node.js 18
nvm use 18
sleep 5

# Install npm (Node.js package manager)
sudo apt-get install npm -y

# Install yarn
sudo npm install -g yarn
echo

echo -e "\033[33mInstall & Initializing Frappe-bench..\033[0m"

sudo pip3 install frappe-bench
bench init --frappe-branch $FRAPPE_VERSION frappe-bench
cd frappe-bench
bench new-site $SITENAME --admin-password $ADMINPASS
sleep 3
bench use $SITENAME
bench get-app --branch $FRAPPE_VERSION erpnext
bench set-config -g developer_mode 1
bench clear-cache
bench get-app --branch $FRAPPE_VERSION hrms
sleep 3
bench install-app erpnext
sleep 3
node -v
echo
echo -e "Enter '\033[33mbench start\033[0m' command to start the Bench"

