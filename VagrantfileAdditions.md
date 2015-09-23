```
  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http="http://mil-proxy:3128/"
    config.proxy.https="http://mil-proxy:3128/"
  end

  config.vm.hostname = "agoodhostname"

  config.vm.define "db" do |db|
    # Box for holding the mysql database and BASE instance
    db.vm.hostname = "basedb"
    db.vm.network "private_network", ip: "192.168.33.10"
    db.vm.network "forwarded_port", guest: 80, host: 8000
  end


  config.vm.provision "shell", inline: /vagrant/$(uname -n)-setup.sh"
  config.vm.network "forwarded_port", guest:80, host:8000, auto_correct:true
```
