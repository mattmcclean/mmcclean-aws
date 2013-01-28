#!/bin/sh

# add the salt repository
add-apt-repository ppa:saltstack/salt

# update
apt-get update
apt-get upgrade -y

# install the salt master
apt-get -y install salt-master

cd /home/ubuntu
git clone https://github.com/mattmcclean/mmcclean-salt-config.git

ln -s /home/ubuntu/mmcclean-salt-config/salt /srv/salt
