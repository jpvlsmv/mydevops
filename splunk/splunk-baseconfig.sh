#!/bin/bash
# Splunk setup commands

SPLUNK=/opt/splunk/bin/splunk

$SPLUNK edit user admin -password 'admin' -role admin -auth admin:changeme

cat >> /opt/splunk/etc/system/local/server.conf <<EOF
[license]
active_group = Free
EOF

$SPLUNK install app /vagrant/sideview-utils-lgpl_135.tgz
$SPLUNK install app /vagrant/sos-splunk-on-splunk_32.tgz
ln -s /vagrant/gcst_vagrant /opt/splunk/etc/apps/gcst_vagrant

$SPLUNK restart splunkd
