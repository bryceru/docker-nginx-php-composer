NGINX PHP7 Composer
===================

The alpine image with:
* Nginx
* PHP 7.4 FPM
* Composer 2
* php.ini override with variables from .env file
* Makefile for quick docker-compose operations

Operations
----------
* make up (docker-compose up) — start all containers
* make bg (docker-compose up -d) — start all containers in background
* make restart (docker-compose restart) — restart all containers
* make down (docker-compose down) — down all containers
* make build (docker-compose build) — build all images & create containers

Structure
---------
* www — for your server files
* .env — for full project & docker environment variables
* docker — config files
    * default — mounted nginx default conf
    * docker-compose.yml — main docker-compose config
    * php
        * Dockerfile — for build php image
        * php.ini — override php settings
        * php.env - env for php.ini (for settings on only restart)
        * opcache.ini – settings for opcache 