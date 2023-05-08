#!/bin/bash

echo requires four parameters: host.domain.tld port username project
echo $1
echo $2
echo $3
echo $4

if [ -z "$4" ]
then
	echo wrong number of arguments
	exit
fi

sudo cp host.domain.tld /etc/nginx/vhosts/

sudo sed -i 's/{{host.domain.tld}}/'$1'/g' /etc/nginx/vhosts/host.domain.tld
sudo sed -i 's/{{port}}/'$2'/g' /etc/nginx/vhosts/host.domain.tld
sudo sed -i 's/{{username}}/'$3'/g' /etc/nginx/vhosts/host.domain.tld
sudo sed -i 's/{{project}}/'$4'/g' /etc/nginx/vhosts/host.domain.tld

sudo mv /etc/nginx/vhosts/host.domain.tld /etc/nginx/vhosts/$1
sudo chmod 644 /etc/nginx/vhosts/$1
sudo chown root:root /etc/nginx/vhosts/$1

echo finished
echo remember to nginx -s reload
