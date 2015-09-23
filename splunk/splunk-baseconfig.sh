#!/bin/bash
# Splunk setup commands

SPLUNK=/opt/splunk/bin/splunk

$SPLUNK edit user admin -password 'admin' -role admin -auth admin:changeme

cat >> /opt/splunk/etc/system/local/server.conf <<EOF
[license]
active_group = Free
EOF

$SPLUNK install app /vagrant/sw/sideview-utils.tar.gz
$SPLUNK install app /vagrant/sw/sos-splunk-on-splunk_32.tgz
#$SPLUNK install app /vagrant/sw/cef-common-event-format-extraction-utilities-123.tgz
#$SPLUNK install app /vagrant/sw/splunk-add-on-for-amazon-web-services_101.tgz
ln -s /vagrant/gcst_vagrant /opt/splunk/etc/apps/gcst_vagrant

$SPLUNK restart splunkd
