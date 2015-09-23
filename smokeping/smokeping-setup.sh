#!/bin/bash

# Install packages
apt-get -y install smokeping fping 

# Fix config
perl -pi -e 's/^sendmail /#sendmail /' /etc/smokeping/config.d/pathnames

cp /vagrant/Targets /etc/smokeping/config.d/pathnames
