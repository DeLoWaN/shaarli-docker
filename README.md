# shaarli-docker

This container provides [Shaarli](https://github.com/shaarli/Shaarli), a personal, minimalist, super-fast, no-database delicious clone

It is buit on [PHP-FPM/Nginx](https://hub.docker.com/r/richarvey/nginx-php-fpm/).

## Usage

Use the docker-compose.yml file provided. You need to install [docker-compose](https://docs.docker.com/compose/install/) version 2.
Remember to edit the port exposed by the shaarli container.

### Using docker-compose

```bash
docker-compose up -d
```

### Using docker run directly (not recommanded for production use)

```bash
docker run -d -p 8080:80 kalumkalac/shaarli 
```

## Production use

It's recommanded, if you have several applications on your server, to use a reverse proxy such as Nginx, which can additionnally handle SSL termination.

Here is an example of configuration to put in */etc/nginx/sites-enabled*:
```
server {
  listen 80;
  server_name example.com;

  location / {
    proxy_pass http://localhost:8080; # Put here the port you map in your docker run command or docker compose file
    proxy_set_header        Host            $host;
    proxy_set_header        X-Real-IP       $remote_addr;
    proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
  }
}
```
