#!/bin/bash

rm /etc/nginx/sites-enabled/00_example.com.maintenance.conf  # removes maintenance symlink
systemctl restart nginx  # restart nginx
