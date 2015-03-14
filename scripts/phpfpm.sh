#!/usr/bin/env bash

# install mysql, nginx
sudo apt-get update
sudo apt-get upgrade

# install nginx
sudo apt-get install nginx

# install mysql
sudo apt-get install mysql-server
sudo mysql_install_db
sudo mysql_secure_installation

# install PHP
sudo apt-get install php5 php5-cli php5-fpm php5-mysql php5-mcrypt php5-json php5-redis php5-sqlite

# install composer
cd ~
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
