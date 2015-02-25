#!/usr/bin/env bash

block="server {
    listen $3;
    server_name $1;
    root \"$2\";

    index index.html;

    charset utf-8;

    location / {
        try_files \$uri \$uri/ /index.html?/\$request_uri;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    access_log off;
    error_log  /var/log/nginx/$1-error.log error;

    error_page 404 /index.html;

    sendfile off;

    location ~ /\.ht {
        deny all;
    }
}
"

echo "$block" > "/etc/nginx/sites-available/$1"
ln -fs "/etc/nginx/sites-available/$1" "/etc/nginx/sites-enabled/$1"
service nginx restart
service php5-fpm restart
