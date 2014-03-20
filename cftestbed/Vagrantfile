# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrant file for a cfengine testbed.
# JMoore 
# Purpose: This box acts as CF Enterprise hub.  Gets CF policies from central
# and branches "cftestbed-" to be merged.

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  # I use Ubuntu.
  config.vm.box = "precise64"

  # Central repository which we will branch for this dev environment
  config.vm.synced_folder "~/infra2/cfengine", "/cfengine-repos" 

  # Repository that we will work with and store our policies in
  config.vm.synced_folder "cfengine", "/cfengine"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Shell Configuration

  # Install latest software and git
  config.vm.provision "shell",
    inline: "apt-get update ; DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade ; apt-get -y install git ; apt-get clean"

  # Install cfengine hub
  config.vm.provision "shell",
    inline: "dpkg -i /vagrant/cfengine-nova-hub_3.5.3-1_amd64.deb ; cf-agent --bootstrap $(hostname -I)"

  # Syncronize our repos
  config.vm.provision "shell",
    inline: "cd /cfengine ; git clone /cfengine-repos . ; T=$(date +%Y%m%d%H%M%S) ; git checkout -b cftestbed-$T ; git push origin cftestbed-$T ; git config --global user.name 'Joe Moore'; git config --global user.email joe.moore@siemens.com"

  # Activate our policies
  config.vm.provision "shell",
    inline: "cd /var/cfengine ; mv masterfiles masterfiles_distrib ; ln -s /cfengine/inputs masterfiles ; service cfengine3 restart" 

end
