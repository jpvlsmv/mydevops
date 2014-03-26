mydevops
========
A repository to record and share how I am setting up Vagrant, Docker, and CFEngine to manage my server and service infrastructure.

Goal
--------
Policies and Processes for setting up and maintaining service containers on physical and virtual resources

Why?
--------
I'm putting together 3 pieces of software that are hard to understand, and hard to make work together.  This repo will probably not have much working code either.

How to use it
----------
1. Create a repo to hold your cfengine configuration.
2. Up the cftestbed Vagrant machine (which clones your repo into the VM's /cfengine and creates a new branch for this work)
3. Make your policy changes and run your tests, then push your commits to origin.
4. Merge in the changes into your repo with "git checkout master ; git merge cftestbed-$TS --no-ff" (Note the --no-ff to make sure that Git will put in a merge-commit record)
5. Repeat for the other (prod and canary) branches that version control your production enviroment.
