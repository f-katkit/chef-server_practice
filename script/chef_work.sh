#!/usr/bin/env bash

#flag check
test -f /etc/bootstrapped && exit

sudo apt-get update -y
sudo apt-get install -y wget ntp openssl curl git zlib1g-dev build-essential libssl-dev libreadline-dev
sudo /etc/init.d/ntp stop
sudo ntpdate ntp.nict.jp
sudo /etc/init.d/ntp start

sudo bash -c "echo '192.168.33.12 chef-server' >> /etc/hosts"
sudo bash -c "echo '192.168.33.13 chef-client' >> /etc/hosts"


# install chef-client
sudo curl -L http://www.opscode.com/chef/install.sh | sudo bash -s - -v 11.14.6
mkdir ~/.chef

# set ssh_key
mkdir ~/.ssh
ssh-keygen -N "" -C chef-work -f ~/.ssh/id_rsa
# ssh-copy-id vagrant@chef-server
# scp vagrant@chef-server:~/.chef/admin.pem ~/.chef/admin.pem
# scp vagrant@chef-server:~/.chef/chef-validator.pem ~/.chef/chef-validator.pem

# setup knife
# knife configure --init
# knife ssl fetch
# knife ssl check
# knife user list
# knife client list

# setup chef node
# bundle exec knife bootstrap chef-client -x vagrant -P vagrant --sudo



sudo bash -c "echo 'done' > /etc/bootstrapped"