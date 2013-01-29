#!/bin/sh

SALT_MASTER=ec2-79-125-80-244.eu-west-1.compute.amazonaws.com

add-apt-repository ppa:saltstack/salt -y
apt-get update -y
apt-get install salt-minion -y
apt-get install salt-master -y
apt-get upgrade -y

if [ -z "$SALT_MASTER" ]; then
    echo "Setting salt master to " $SALT_MASTER
    # Set salt master location and start minion
    sed -i 's/#master: salt/master: '$SALT_MASTER'/' /etc/salt/minion
    service salt-minion restart
fi
