# Production Setup
This setup guide assumes you have moved the code to the production server,
installed docker, docker-compose as well as postgresql-client on your ubuntu machine.

Feel free to modify script/file names but make sure they are consistent across configs.

### Gunicorn and Database Setup:
* Configs for running the DB Server and Gunicorn Web Server are defined in production.yml
* Setup you gunicorn server and postgres server as services. Create the following files:
```
# /etc/systemd/system/database.service

[Unit]
Description=Docker Compose Application DB Service
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/path/to/sample_project/
ExecStart=/usr/local/bin/docker-compose -f /path/to/sample_project/production.yml up -d db
ExecStop=/usr/local/bin/docker-compose -f /path/to/sample_project/production.yml stop db
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
```

```
# /etc/systemd/system/web.service

[Unit]
Description=Docker Compose Application Web Service
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/path/to/sample_project/
ExecStart=/usr/local/bin/docker-compose -f /path/to/sample_project/production.yml up -d web
ExecStop=/usr/local/bin/docker-compose -f /path/to/sample_project/production.yml stop web
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
```
* enable each service created
```
sudo systemctl enable database
sudo systemctl enable web
```
* start each service
```
sudo systemctl start database
sudo systemctl start web
```

### Database Backups:
Database backups will be taken using pgdump so install postgresql-client with `apt get-install postgresql-client`

Find sample scripts for backup and restore in the `scripts/` directory.

### NGINX Setup:
* Install nginx on server `sudo apt-get install -y 'nginx=1.18.*'`
* Start nginx and confirm it's running with `sudo systemctl start nginx && sudo systemctl status nginx`. 
You should see an active status if all is well.
* Copy the contents of `nginx/01_example.com.conf` to a file `/etc/nginx/sites-available/01_example.com.conf`
* Test conf with `sudo service nginx configtest /etc/nginx/sites-available/01_example.com.conf`
* Delete all configurations in `/etc/nginx/sites-available/`
* Enable config with `sudo ln -s /etc/nginx/sites-available/01_example.com.conf /etc/nginx/sites-enabled/`
* Restart nginx with `sudo systemctl restart nginx`
* Nginx should now forward all requests to gunicorn for handling.
* To setup NGINX for automatic restart when it goes down, run `systemctl edit nginx`
Paste in and save it -
```
[Service]
Restart=always
```

### Maintenance Mode:
Putting the site in maintenance mode involves enabling the maintenance config at `nginx/00_example.com.maintenance.conf`
the commands for doing this can be found in the `scripts/` directory.

```
# nginx/00_example.com.maintenance.conf

root /path/to/upwork/sample_project/maintenance;  # modify path to maintenance home (contains index.html)
```


### LetsEncrypt Setup:
* Install certbot on your machine by following the instructions on their website: https://certbot.eff.org/instructions?ws=nginx&os=ubuntufocal
* Configure nginx to use newer versions of TLS by replacing a line in the nginx config
```
# /etc/nginx/nginx.conf

ssl_protocols TLSv1 TLSv1.1 TLSv1.2;

# replace with
ssl_protocols TLSv1.2 TLSv1.3;
```
* run `nginx -t` to confirm nginx supports tls 1.3
* run the following command and follow the prompts to install the certificate `sudo certbot --nginx --rsa-key-size 4096 --no-redirect`
* reload nginx with `sudo systemctl reload nginx`
