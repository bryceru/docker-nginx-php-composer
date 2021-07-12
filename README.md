NGINX PHP7 Composer
===================

Image on alpine with:
* Nginx
* PHP 7.4 FPM
* Composer 2
* php.ini override with variables from .env file
* Makefile for quick docker-compose operations

Operations:
* make up (docker-compose up)
* make bg (docker-compose up -d)
* make down (docker-compose down)
* make build (docker-compose build)
