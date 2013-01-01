#!/bin/sh

yum -y update
yum -y install httpd
yum -y install php php-mysql

service httpd start
chkconfig httpd on 
