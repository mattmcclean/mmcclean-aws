#!/bin/sh

yum -y update

# install git and python lib
yum -y install python-paramiko git

# install beeswithmachine guns from github
cd /tmp && git clone git://github.com/newsapps/beeswithmachineguns.git
cd beeswithmachineguns && python setup.py install

# setup AWS credentials
echo '[Credentials]' > /home/ec2-user/.boto
echo 'aws_access_key_id=AKIAJYV4WEN6EEC3PHDQ' >> /home/ec2-user/.boto
echo 'aws_secret_access_key=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' >> /home/ec2-user/.boto
echo '[Boto]' >> /home/ec2-user/.boto
echo 'ec2_region_name=eu-west-1' >> /home/ec2-user/.boto
echo 'ec2_region_endpoint=eu-west-1.ec2.amazonaws.com' >> /home/ec2-user/.boto

chown ec2-user:ec2-user /home/ec2-user/.boto

# Setup s3curl
cd /tmp && wget http://public.dowdandassociates.com/content/howto-install-aws-cli/install_s3curl.sh
chmod +x install_s3curl.sh
./install_s3curl.sh

cat <<'EOF'>>/home/ec2-user/.s3curl
%awsSecretAccessKeys = (
main => {
id => 'AKIAJYV4WEN6EEC3PHDQ',
key => 'n1UNtzGw0wmMAa9GWvf3XP4WFNCFjBoZVitXZ5qS',
},
);
EOF

chown ec2-user:ec2-user /home/ec2-user/.s3curl
chmod 600 /home/ec2-user/.s3curl

cd /tmp 
s3curl.pl --id main -- https://mmcclean-beetest.s3.amazonaws.com/beekey.pem -o beekey.pem
chown ec2-user:ec2-user beekey.pem
chmod 600 beekey.pem
mv beekey.pem /home/ec2-user/.ssh

