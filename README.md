# shaarli-docker

This container provides [Shaarli](https://github.com/shaarli/Shaarli), a personal, minimalist, super-fast, no-database delicious clone.

It is buit on [PHP-FPM/Nginx](https://hub.docker.com/r/richarvey/nginx-php-fpm/).

## Usage

Use the docker-compose.yml file provided. You need to install [docker-compose](https://docs.docker.com/compose/install/) version 2.
Remember to edit the port exposed by the shaarli container.

```
version: '2'
services:
  data:
    image: tianon/true
    volumes:
     - /usr/share/nginx/shaarli/data
    restart: always
  shaarli:
    image: kalumkalac/shaarli:0.7-1
    ports:
     - 8080:80
    volumes_from:
     - data
    restart: always
```

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

## Backup

All your data is stored in the folder */usr/share/nginx/shaarli/data* accessible from the data container. Get the name of the data container using `docker ps` command. Then, use the `docker cp` command:
```bash
docker cp shaarli_data_1:/usr/share/nginx/shaarli/data/ ~/backup_dir
```

## Restore

Do the opposite of backup. Get the name of the data container using `docker ps` command. Then, use the `docker cp` command:
```bash
docker cp ~/backup_dir shaarli_data_1:/usr/share/nginx/shaarli/data/
```

## Upgrade

*This protocol applies if you use the docker-compose installation.*

To upgrade your shaarli installation to the last version, check if a new version of [kalumkalac/shaarli](https://hub.docker.com/r/kalumkalac/shaarli/tags/) docker is released.

Remove the shaarli container (safe since the data is in the data container).

```bash
docker-compose stop shaarli
docker-compose rm shaarli
```

Then use `docker pull` to pull the newest tag :

```bash
docker pull kalumkalac/shaarli:0.7-1
```

Update your docker-compose.yml file accordingly :

```bash
shaarli:
    image: kalumkalac/shaarli:0.7-1
```

Create the missing shaarli container with the `docker-compose up` command:

```bash
docker-compose up -d
```
