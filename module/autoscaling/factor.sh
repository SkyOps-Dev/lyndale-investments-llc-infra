!/bin/bash

#Update package lists
 sudo apt update

#Install Nginx
 sudo apt install nginx -y

#Start Nginx service
 sudo systemctl start nginx

#Enable Nginx to start on boot
 sudo systemctl enable nginx