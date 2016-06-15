#!/bin/bash
if [ ! -e /usr/share/nginx/shaarli/data/.htaccess ]; then
    chmod -R a+wx data
    wget https://raw.githubusercontent.com/shaarli/Shaarli/master/data/.htaccess /usr/share/nginx/shaarli/data/
fi
/bin/bash /start.sh
