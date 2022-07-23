#!/bin/bash

rm /etc/nginx/sites-enabled/00_example.com.maintenance.conf  # removes maintenance symlink, change if the file name has been modified
systemctl restart nginx  # restart nginx
