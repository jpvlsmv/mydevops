Vagrant environment for testing and developing cfengine policies.

Download cfengine-nova-hub*.deb from cfengine.com (watch their licensing) and mkdir cfengine.

Modify the /cfengine-repos shared location to point to your centralized cfengine policy repo.

Most of the setup is automated via the Makefile now, but you have to walk through it manually.  Review and understand what the targets are doing (they're in order)
