#!/bin/bash
# install mariadb
sudo apt update
sudo apt install -y mariadb-server

# allow remote connections
echo "[mysqld]" | sudo tee -a /etc/mysql/my.cnf
echo "bind-address = 0.0.0.0" | sudo tee -a /etc/mysql/my.cnf
sudo systemctl restart mariadb

# create db user
sudo mysql << EOF
CREATE DATABASE wordpress;
CREATE USER dbuser@'%' IDENTIFIED BY 'dbpass';
GRANT ALL ON wordpress.* TO dbuser@'%';
FLUSH PRIVILEGES;
EOF
