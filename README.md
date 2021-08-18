NGINX PHP 7 Composer Percona
============================

Branches
--------
* `master` — main branch (php on 9000 port)
* ✓`socket` — branch with php on socket
* `mutagen` — branch with php on socket and all files sync with mutagen (performance docker php resolving)

The alpine image with:
* Nginx
* PHP 7.4 FPM
  * exif
  * pdo
  * bcmath
  * pdo_mysql
  * zip
  * intl
  * iconv
  * pcntl
  * opcache
  * acl
  * curl
  * gettext
  * OpenSSL
  * PostgreSQL extension
  * gd2 with png, jpeg, webp, freetype
  * ...etc
* Composer 2
* Percona DB / MySQL
* php.ini override with variables from .env file
* Makefile for quick docker-compose operations

Operations
----------
* `make help` — Show help
* `make force` (docker-compose up) — Start all containers foreground with recreation
* `make up` (docker-compose up --no-recreate) — Start all containers foreground
* `make bg` (docker-compose up --no-recreate -d) — Start all containers background
* `make restart list="php nginx"` (docker-compose up restart) — Restart all started containers
* `make stop list=php` (docker-compose stop) — Stop all started containers
* `make down` (docker-compose down) — Stop all started for development containers
* `make build` (docker-compose build) — Build images & create containers
* `make dump` — Dump database
* `make command "ls -la"` — Run commmand shell in php container
* `make logs` — Show logs
* `make tail` — Tail logs
* `make shell php` — Run shell for container

Structure
---------
* `www` — for your server files
* `.env` — for full project & docker environment variables
* `docker` — config files
  * `default` — mounted nginx default conf
  * `docker-compose.yml` — main docker-compose config
  * `php`
    * `Dockerfile` — for build php image
    * `php.ini` — override php settings
    * `php.env` - env for php.ini (for settings on only restart)
