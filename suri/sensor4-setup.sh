#!/bin/bash
# Script for setting up suricata

DEBIAN_FRONTEND=noninteractive
export DEBIAN_FRONTEND

apt-add-repository ppa:oisf/suricata-stable
apt-get update
apt-get -y install suricata securityonion-barnyard2 oinkmaster

mkdir /var/log/nsm /var/log/barnyard2
ln -s /etc/suricata/rules /etc/nsm/rules
ln -s /etc/suricata /etc/snort

# Generate /etc/snort/sid-msg.map
/usr/share/oinkmaster/create-sidmap.pl /etc/nsm/rules > /etc/snort/sid-msg.map

# Run barnyard2
#( barnyard2 -c /vagrant/barnyard2.conf -v -f unified2.alert -d /var/log/nsm -i eth1 -h sensor3 2>&1 | tee -a /var/log/barnyard2.out | logger -t barnyard -i --server 192.168.33.9 -P 8514 -u /dev/null ) &

#( suricata -c /vagrant/suricata.yaml -i eth1 2>&1 | tee -a /var/log/suricata.out | logger -t suricata -i --server 192.168.33.9 -P 8514 -u /dev/null ) &

#sleep 5

# Add some test data
#ping -s 1400 -c 5 192.168.33.1

