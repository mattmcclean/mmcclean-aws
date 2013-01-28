#!/bin/sh

# add the salt repository
add-apt-repository ppa:saltstack/salt

# update
apt-get update

# install the salt master
apt-get -y install salt-minion
