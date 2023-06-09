# nginxShareConfig
For configuring nginx for multiple users  
Unfortunately, this readme file may be missing some steps required to get things working.  Please update this file as you find these things.  
  
The following assumes that you are starting with a fresh Amazon Linux 2023 (or Linux 2 AMI) and nothing has be set up. 
  
You will want to start with some basic server setup routines:  
Create a 1G swap file:  
sudo fallocate -l 1G /swapfile  
Change its permission to only root could access and change:  
sudo chmod 600 /swapfile  
Make it swap:  
sudo mkswap /swapfile  
Activate:  
sudo swapon /swapfile  
View swap:  
free -m  
  
Udate repositories:  
sudo yum update  
  
Install docker & docker-compose:  
sudo yum install docker  
sudo systemctl start docker  
sudo systemctl enable docker  
  
https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose  
sudo chmod +x /usr/local/bin/docker-compose  
  
  
Install nginx:  
sudo yum install nginx  
sudo systemctl enable nginx  
  
  

host.domain.tld is a template of a virtual host file, using {{handlebars}}.  When the setupVhost.sh script is run, with the required parameters, those parameters are substituted into a copy of the template file, which is then placed in the /etc/nginx/vhosts directory.  You will have to create that directory, and add a line to the nginx configuration file telling it to load the files in the vhosts directory (as shown in the following steps).    
  
sudo mkdir /etc/nginx/vhosts  
sudo chmod 755 /etc/nginx/vhosts  
echo 'include /etc/nginx/vhosts/*;' | sudo tee /etc/nginx/conf.d/includeVhosts.conf  
  
  
The setupVhost.sh script requires four parameters; the hostname, the port that express will listen on, the username, and the port that react will listen on.  
  
For example, running the script would like this (without quotes): "./setupVhost.sh winter.topsecondhost.com 8080 winter 3000"  
where the person with the name Winter, has the username winter, and browser requests to winter.topsecondhost.com will be routed to ports 8080, or 3000, depending on the uri path.  For example, requests to winter.topsecondhost.com/api are proxied to the 8080 port.  
  
For Stewart, the command would look like "./setupVhost.sh stewart.topsecondhost.com 8081 stewart 3001"  
Notice how the ports are not the same.  Each user has their own set of ports associated with their hostname, such that they have their own development website.  
  
build.domain.tld is meant for the production version of the website.  In React, you can "npm run build" and a static version of the site is generated.  You can then move this to the directory that is being served as your app in production.  
  
usersetup.sh simply creates a new user along with the required directories for the webserver to be able to serve their work.  This is accomplished by creating a public_html directory within their home directory that is actually a symbolic link to a directory in /var/www...   The reason for this is that the webserver cannot read files in user home directories, but it can read files in /var/www....  
  
Once the user has been created with that script, their ssh keys will still need to be added to their profiles.  
  
mkdir .ssh  
cd .ssh  
touch authorized_keys  
chmod 600 authorized_keys  
vim authorized_keys  
(and paste the public key information into the file)  


