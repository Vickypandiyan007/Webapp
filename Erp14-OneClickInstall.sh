#!/bin/bash

set -exo pipefail
echo

# Ask for permission
read -p "Do you want to install the ERPNext 14 and It's dependencies? (y/n): " answer

# Check the user's response
if [[ "$answer" =~ ^[Yy]$ ]]; then
	echo
        read -p "Set the Sitename : " SITENAME
        read -s -p "Set the Site Password : " ADMINPASS

	echo
# Installing Depentencies
        echo "Updating & upgrading system.."

        sudo apt-get update && sudo apt-get upgrade -y
	echo
        echo "Installing git & Python.."

        sudo apt-get install -y git \
        python3-dev \
        python3.10-dev \
        python3-setuptools \
        python3-pip \
        python3-distutils \
        python3.10-venv \
        software-properties-common
	echo
        echo "Installing Mariadb & Redis server.."
        sudo apt-get install -y mariadb-client \
        mariadb-server \
        redis-server
	echo
        echo "Installing other dependencies.."
        sudo apt-get install -y xvfb \
        libfontconfig \
        wkhtmltopdf \
        libmysqlclient-dev \
        curl
	echo
        echo "Installing secure Mysql.."
        sudo mysql_secure_installation
	echo
        echo "Changing the configuration of mysql.."
        sleep 2
# Changing mysql configuration
        echo "[mysqld]
        character-set-client-handshake = FALSE
        character-set-server = utf8mb4
        collation-server = utf8mb4_unicode_ci

        [mysql]
        default-character-set = utf8mb4" | sudo tee -a /etc/mysql/my.cnf
	
	echo
	echo "Restarting mysql.."
        sudo service mysql restart
        sleep 2

        echo "Installing Node, npm & yarn..."

        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

        # Install Node.js 16.15.0
        nvm install 16.15.0

        # Use Node.js 16.15.0
        nvm use 16.15.0
	sleep 5

        # Install npm (Node.js package manager)
        sudo apt-get install npm -y

        # Install yarn
        sudo npm install -g yarn
	
	echo
        echo "Install & Initializing Frappe-bench.."

        sudo pip3 install frappe-bench
        bench init --frappe-branch version-14 frappe-bench
        cd frappe-bench
        bench new-site $SITENAME --admin-password $ADMINPASS
        sleep 3
        bench get-app --branch version-14 erpnext
	bench get-app --branch version-14 hrms
        sleep 3
        bench use $SITENAME
        bench install-app erpnext
        sleep 3
        echo "Enter 'bench start' command to start the Bench"

else
        # User chose not to install
        echo "Installation cancelled by user."
fi
