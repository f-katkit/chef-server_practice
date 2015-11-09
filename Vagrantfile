Vagrant.configure("2") do |config|

  $script_for_server = <<EOF
  sudo chmod +x /vagrant/script/chef_server.sh
  sudo -u vagrant -i /vagrant/script/chef_server.sh
EOF

  $script_for_work = <<EOF
  sudo chmod +x /vagrant/script/chef_work.sh
  sudo -u vagrant -i /vagrant/script/chef_work.sh
EOF

  $script_for_client = <<EOF
  sudo chmod +x /vagrant/script/chef_client.sh
  sudo -u vagrant -i /vagrant/script/chef_client.sh
EOF

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end
  
  config.vm.define :chef_server do |host|
    host.vm.box = "centos64"
    host.vm.hostname = "chef-server"
    host.vm.box_url = 'http://download.parallels.com/desktop/vagrant/centos64.box'
    host.vm.network :private_network, ip: "192.168.33.12"
    host.vm.provision :shell, :inline => $script_for_server
 end

  config.vm.define :chef_work do |host|
    host.vm.box = "ubuntu1404"
    host.vm.box_url = 'https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box'
    host.vm.hostname = "chef-work"
    host.vm.network :private_network, ip: "192.168.33.11"
    host.vm.provision :shell, :inline => $script_for_work
  end

  config.vm.define :chef_client do |host|
    host.vm.box = "centos65"
    host.vm.box_url = 'http://download.parallels.com/desktop/vagrant/centos64.box'
    host.vm.hostname = "chef-client"
    host.vm.network :private_network, ip: "192.168.33.13"
    host.vm.provision :shell, :inline => $script_for_client
  end
end
