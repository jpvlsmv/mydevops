#!/bin/bash
# Script for setting up mysql/php/etc for base

DEBIAN_FRONTEND=noninteractive
export DEBIAN_FRONTEND

apt-get -y install snort barnyard2

service snort start

# Add some test data
ping -s 1400 -c 5 192.168.33.1

