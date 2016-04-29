FROM richarvey/nginx-php-fpm
RUN cat /etc/nginx/sites-enabled/default.conf
RUN sed s#/usr/share/nginx/html#/usr/share/nginx/shaarli# -i /etc/nginx/sites-enabled/default.conf
WORKDIR /usr/share/nginx/
RUN git clone https://github.com/shaarli/Shaarli.git -b stable shaarli
WORKDIR /usr/share/nginx/shaarli
RUN chmod -R a+wx cache data pagecache tmp

# Expose Ports
EXPOSE 443
EXPOSE 80

CMD ["/bin/bash", "/start.sh"]
