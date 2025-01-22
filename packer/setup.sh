#!/usr/bin/env bash
sudo dnf install nginx -y
sudo rm -rf /usr/share/nginx/html/*
sudo echo "<h1> This is Index chaitu </h1>"  > /usr/share/nginx/html/index.html
sudo systemctl start nginx
sudo echo "This is tmp" > /tmp/1.txt
sudo dnf install git -y