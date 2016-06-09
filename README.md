# shaarli-docker

This container provides [Shaarli](https://github.com/shaarli/Shaarli), a personal, minimalist, super-fast, no-database delicious clone

It is buit on [PHP-FPM/Nginx](https://hub.docker.com/r/richarvey/nginx-php-fpm/).

## Usage

```bash
docker run -d -p 8080:80 kalumkalac/shaarli
```

## Production

It's recommanded, if you have several applications on your server, to use a reverse proxy such as Nginx, which can additionnally handle SSL termination.

Here is an example of configuration to pu in */etc/nginx/sites-enabled*:
```php
server {
  listen 80;
  server_name exeample.com;

  location / {
    proxy_pass http://localhost:8080; # Put here the port you map in your docker run command or docker compose file
    proxy_set_header        Host            $host;
    proxy_set_header        X-Real-IP       $remote_addr;
    proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
  }
}
```
