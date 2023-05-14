#!/bin/bash

echo requires one arguments: username
echo $1

if [ -z "$1" ]
then
	echo error no username provided
	        exit
fi

sudo mkdir -p /var/www/$1/public_html
sudo chown -R $1:root /var/www/$1
sudo chmod -R 2775 /var/www/$1/public_html
sudo ln -s /var/www/$1/public_html /home/$1/public_html

