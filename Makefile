#!/usr/bin/make
# Makefile readme (ru): <http://linux.yaroslavl.ru/docs/prog/gnu_make_3-79_russian_manual.html>
# Makefile readme (en): <https://www.gnu.org/software/make/manual/html_node/index.html#SEC_Contents>

.PHONY: help force up restart stop down command logs tail shell

shell = /bin/sh

# Important: Local images naming should be in docker-compose naming style

list ?= smtpserver percona php nginx

DOCKER_DIR := ./docker

DB_CONTAINER_NAME := percona

GOAL   := $(firstword $(MAKECMDGOALS))
PARAMS := $(filter-out $(GOAL),$(MAKECMDGOALS))

docker_bin := $(shell command -v docker 2> /dev/null)
docker_compose_bin := $(shell command -v docker-compose 2> /dev/null)

# This will output the help for each task. thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## | // "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-10s\033[32m%-26s\033[0m %s\n", $$1, $$3, $$2}' $(MAKEFILE_LIST)

force:## Start all containers foreground with recreation
	$(docker_compose_bin) -f "$(DOCKER_DIR)/docker-compose.yml" --env-file=".env" up

up: ## Start all containers foreground
	$(docker_compose_bin) -f "$(DOCKER_DIR)/docker-compose.yml" --env-file=".env" up --no-recreate

bg: ## Start all containers background
	$(docker_compose_bin) -f "$(DOCKER_DIR)/docker-compose.yml" --env-file=".env" up -d --no-recreate

restart: ## Restart all started containers // restart list="php nginx"
	$(docker_compose_bin) -f "$(DOCKER_DIR)/docker-compose.yml" --env-file=".env" restart $(list)

stop: ## Stop all started containers // stop list=php
	$(docker_compose_bin) -f "$(DOCKER_DIR)/docker-compose.yml" --env-file=".env" stop $(list)

down: ## Stop all started for development containers
	$(docker_compose_bin) -f "$(DOCKER_DIR)/docker-compose.yml" --env-file=".env" down

build: ## Build images & create containers
	$(docker_compose_bin) -f "$(DOCKER_DIR)/docker-compose.yml" --env-file=".env" build

dump: ## Dump database
	$(docker_compose_bin) -f "$(DOCKER_DIR)/docker-compose.yml" --env-file=".env" exec $(DB_CONTAINER_NAME) sh /var/backup/backup.sh

command: ## Run commmand shell in php container // command "ls -la"
	$(docker_compose_bin) -f "$(DOCKER_DIR)/docker-compose.yml" --env-file=".env" exec php sh -c "$(PARAMS)"

logs: ## Show logs
	$(docker_compose_bin) -f "$(DOCKER_DIR)/docker-compose.yml" --env-file=".env" logs $(list)

tail: ## Tail logs
	$(docker_compose_bin) -f "$(DOCKER_DIR)/docker-compose.yml" --env-file=".env" logs $(list) -f

shell: ## Run shell for container // shell php
	$(docker_compose_bin) -f "$(DOCKER_DIR)/docker-compose.yml" --env-file=".env" exec $(PARAMS) sh

%:;
