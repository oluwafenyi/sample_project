#!/bin/bash

ln -s /path/to/sample_project/nginx/00_example.com.maintenance.conf /etc/nginx/sites-enabled/  # creates symlink ensuring the maintenance config gets parsed first
systemctl restart nginx  # restart nginx
