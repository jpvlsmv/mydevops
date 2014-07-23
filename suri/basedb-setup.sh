#!/bin/bash
# Script for setting up mysql/php/etc for base

DEBIAN_FRONTEND=noninteractive
export DEBIAN_FRONTEND

apt-get -y install apache2 libapache2-mod-php5 mysql-server php5-mysql php5-adodb libphp-adodb
mysqladmin create snort
mysql snort < /vagrant/create_mysql.txt

#cp /vagrant/snort.debian.conf /vagrant/database.conf /etc/snort/
#rm /etc/snort/db-pending-config

cd /var/www
tar xvfz /vagrant/base-1.4.5.tar.gz
cp /vagrant/base_conf.php base-1.4.5/

mysql snort < /var/www/base-1.4.5/sql/create_base_tbls_mysql.sql
mysql <<EOF
grant all on snort.* to 'snort'@'192.168.33.%'  identified by 'snort';
EOF
perl -pi -e 's/^bind-address/#bind-address/' /etc/mysql/my.cnf

service mysql restart
service apache2 restart
#service snort start

# Add some test data
#ping -s 1400 -c 5 192.168.33.1

