#!/bin/bash
# Splunk setup commands

dpkg -i /vagrant/sw/splunk-6.1.2-213098-linux-2.6-amd64.deb || exit 1

SPLUNK=/opt/splunk/bin/splunk

su - splunk -c "$SPLUNK start --accept-license"
$SPLUNK enable boot-start -user splunk

$SPLUNK edit user admin -password 'admin' -role admin -auth admin:changeme

cat >> /opt/splunk/etc/system/local/server.conf <<EOF
[license]
active_group = Free
EOF

#$SPLUNK install app /vagrant/sw/sideview-utils-lgpl_135.tgz
#$SPLUNK install app /vagrant/sw/sos-splunk-on-splunk_32.tgz
#$SPLUNK install app /vagrant/sw/cef-common-event-format-extraction-utilities_123.tgz
#ln -s /vagrant/gcst_vagrant /opt/splunk/etc/apps/gcst_vagrant

$SPLUNK restart splunkd
