#!/usr/bin/make -f
# Makefile for building the cftestbed
# Assumptions: 
#  . vagrant works
#  . git works
#  . cfengine-nova-hub-3.5.3-1_amd64.deb has been downloaded and is in this dir

all: cleanrepos initpolicy mergebranch addenv addenvmerge

# First, we build some empty repositories
cleanrepos:
	mkdir cfengine-repos 
	git init cfengine-repos/inputs
	git init cfengine-repos/environments
	( cd cfengine-repos/inputs ; touch .gitignore ; git commit -a -m 'Initial gitignore' ; git branch prod )
	( cd cfengine-repos/environments ; touch .gitignore ; git commit -a -m 'Initial gitignore' ; git branch prod ; git branch test )

# Or we can clone a remote repository.  Set REMOTE_REPOS to the location.
clonerepos:
	mkdir cfengine-repos
	git clone $REMOTE_REPOS/inputs cfengine-repos/inputs
	git clone $REMOTE_REPOS/environments cfengine-repos/environments

# Next, bring up the vagrant machine to get the initial policy
initpolicy:
	vagrant up # Might need to set HTTPS_PROXY=http://myproxy:3128/
	vagrant ssh -c 'sudo su - -c "cd /cfengine/inputs ; cp -r /var/cfengine/masterfiles_distrib/* . ; git add . ; git commit -m "Initial policy import" ; git push'
	vagrant destroy

mergebranch:
	( cd cfengine-repos/inputs ; git checkout master; git merge --no-ff `git branch --no-merged | grep cftestbed` )
	( cd cfengine-repos/inputs ; git checkout prod; git merge --no-ff `git branch --no-merged | grep cftestbed` )
	( cd cfengine-repos/environments ; git checkout master; git merge --no-ff --no-merged | grep cftestbed` )
	( cd cfengine-repos/environments ; git checkout test; git merge --no-ff --no-merged | grep cftestbed` )
	( cd cfengine-repos/environments ; git checkout prod; git merge --no-ff --no-merged | grep cftestbed` )

# At this point, we have the distributed CFEngine policies checked in to our
# new repository.  We can work to make our customizations
addenv:
	cd cfengine-repos/inputs
	git checkout -b addenv
	patch -p0 ../../mainpromises.patch
	git add promises.cf
	git commit -m 'Add Environment hooks'
	cd ../environments
	git checkout -b addenv
	cp ../../env_promises.cf ../../cfbrag.cf .
	git add env_promises.cf cfbrag.cf
	git commit -m 'Add Environment hooks'

addenvmerge:
	( cd cfengine-repos/inputs ; git checkout master; git merge --no-ff addenv )
	( cd cfengine-repos/inputs ; git checkout prod; git merge --no-ff addenv )
	( cd cfengine-repos/environments ; git checkout master; git merge --no-ff addenv )
	( cd cfengine-repos/environments ; git checkout test; git merge --no-ff addenv )
	( cd cfengine-repos/environments ; git checkout prod; git merge --no-ff addenv )

# And now we have everything set.
# Vagrant up a new cftestbed VM, make changes to policy and test them
# Then merge the cftestbed-$TSTAMP branch into master, test, and prod

