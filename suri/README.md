Here we have a Vagrant environment that's replicating several components of an IDS system.

VM "db" runs MySQL and the BASE web interface

VM "sensor1" uses snort and the database output plugin (deprecated) to push events to MySQL.

VM "sensor2" uses snort to write a unified2 outfile that barnyard2 reads and pushes to MySQL.

Note, there's not any security on the MySQL instance.  Keep it on the private network, please. :)
