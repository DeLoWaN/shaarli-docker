FROM richarvey/nginx-php-fpm:latest
# Change rootdir since it's a volume in base image, we can't write in this folder
RUN apt-get update
RUN apt-get -y install wget
RUN sed "s#/usr/share/nginx/html#/usr/share/nginx/shaarli#" -i /etc/nginx/sites-enabled/default.conf
RUN sed "s#display_errors = On#display_errors = Off#" -i /etc/php5/fpm/php.ini
ADD shaarli.sh /shaarli.sh

WORKDIR /usr/share/nginx/
RUN git clone https://github.com/shaarli/Shaarli.git -b v0.7.0 shaarli
WORKDIR /usr/share/nginx/shaarli
RUN chmod -R a+wx cache data pagecache tmp

# Expose Ports
EXPOSE 443
EXPOSE 80

VOLUME ["/usr/share/nginx/shaarli/data"]
CMD ["/bin/bash", "/shaarli.sh"]
