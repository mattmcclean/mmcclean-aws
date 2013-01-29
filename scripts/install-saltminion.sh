#!/bin/sh

add-apt-repository ppa:saltstack/salt -y
apt-get update -y
apt-get install salt-minion -y
apt-get install salt-master -y
apt-get upgrade -y

echo "Setting salt master to " $SALT_MASTER
# Set salt master location and start minion
sed -i 's/#master: salt/master: '$SALT_MASTER'/' /etc/salt/minion
salt-minion -d
