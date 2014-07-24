#!/bin/bash
# Script for setting up mysql/php/etc for base

DEBIAN_FRONTEND=noninteractive
export DEBIAN_FRONTEND

apt-get -y install snort-mysql 

cp /vagrant/snort.debian.conf /vagrant/database.conf /etc/snort/
rm /etc/snort/db-pending-config

service snort start

# Add some test data
ping -s 1400 -c 5 192.168.33.1

