#!/usr/bin/env bash

#flag check
test -f /etc/bootstrapped && exit

sudo yum update -y
sudo yum install -y wget ntp openssl-devel curl git readline-devel
sudo ntpdate ntp.nict.jp

sudo bash -c "echo '192.168.33.12 chef-server' >> /etc/hosts"

#install chef-server
curl -s https://packagecloud.io/install/repositories/chef/stable/script.rpm.sh | sudo bash
sudo yum install -y chef-server-11.1.6-1.el6.x86_64

#install ruby (*setup rbenv)
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source .bash_profile

rbenv install 2.2.3
rbenv rehash
rbenv global 2.2.3

#setting for chef
rbenv exec gem install padrino

sudo chef-server-ctl reconfigure
sudo chef-server-ctl test

#place ssl-key
mkdir ~/.chef
cd /etc/chef-server/
sudo cp -r /etc/chef-server/admin.pem chef-validator.pem ~/.chef
sudo chown vagrant:vagrant ~/.chef/*.pem 

sudo bash -c "echo 'done' > /etc/bootstrapped"
