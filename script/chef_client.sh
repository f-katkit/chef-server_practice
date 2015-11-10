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



sudo bash -c "echo 'done' > /etc/bootstrapped"
