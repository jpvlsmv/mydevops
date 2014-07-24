#!/bin/bash
# Script for setting up mysql/php/etc for base

DEBIAN_FRONTEND=noninteractive
export DEBIAN_FRONTEND

apt-get update
apt-get -y install snort securityonion-barnyard2 oinkmaster

# Generate /etc/snort/sid-msg.map
/usr/share/oinkmaster/create-sidmap.pl /etc/snort/rules > /etc/snort/sid-msg.map

# Configure snort
cp /vagrant/snort.conf /vagrant/snort.debian.conf /etc/snort/

service snort start

# Run barnyard2
mkdir /var/log/barnyard2
( barnyard2 -c /vagrant/barnyard2.conf -v -f unified2.log -d /var/log/snort -i eth1 -h sensor2 2>&1 | logger -t barnyard -i --server 192.168.33.9 -P 8514 -u /dev/null ) &

# Add some test data
ping -s 1400 -c 5 192.168.33.1

