Vagrant.configure("2") do |config|

  $script_for_server = <<EOF
  sudo chmod +x /vagrant/chef_server.sh
  sudo -u vagrant -i /vagrant/chef_server.sh
EOF

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
   end
  
  config.vm.define :chef_work do |host|
    host.vm.box = "ubuntu1410"
    host.vm.hostname = "chef-work"
    host.vm.network :private_network, ip: "192.168.33.11"
   end

  config.vm.define :chef_server do |host|
    host.vm.box = "centos6"
    host.vm.hostname = "chef-server"
    host.vm.network :private_network, ip: "192.168.33.12"
    host.vm.provision :shell, :inline => $script_for_server
 end

  config.vm.define :my_node do |host|
    host.vm.box = "centos6"
    host.vm.hostname = "my-node"
    host.vm.network :private_network, ip: "192.168.33.13"
  end
end
