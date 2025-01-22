#!/usr/bin/env bash
sudo dnf install nginx -y
sudo systemctl start nginx
sudo echo "This is tmp" > /tmp/1.txt