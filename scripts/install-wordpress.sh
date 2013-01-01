#!/bin/sh

# set the parameters
DB_NAME=blog
DB_USERNAME=awsuser
DB_PASSWORD=mypassword
DB_HOST=mydbinstance.cfzvw6eveeul.eu-west-1.rds.amazonaws.com

# update packages
yum -y update
# install Apache and PHP
yum -y install httpd
yum -y install php php-mysql

# Install Wordpress
cd /var/www/html
wget http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
mv wordpress blog

cd blog
mv wp-config-sample.php wp-config.php
sed -i 's/database_name_here/$DB_NAME/g' wp-config.php
sed -i 's/username_here/$DB_USERNAME/g' wp-config.php
sed -i 's/password_here/$DB_PASSWORD/g' wp-config.php
sed -i 's/localhost/$DB_HOST/g' wp-config.php

service httpd start
chkconfig httpd on 
