#!/bin/bash

echo requires two arguments: username project
echo $1
echo $2

if [ -z "$2" ]
then
	echo wrong number of arguments
	        exit
fi

sudo mkdir -p /var/www/$1/$2
sudo chown -R $1:root /var/www/$1
sudo chmod -R 2775 /var/www/$1
sudo cp -r /usr/share/nginx/html /var/www/$1/$2
sudo chown -R $1:root /var/www/$1
sudo ln -s /var/www/$1/$2 /home/$1/$2

