#!/usr/bin/make
# Makefile readme (ru): <http://linux.yaroslavl.ru/docs/prog/gnu_make_3-79_russian_manual.html>
# Makefile readme (en): <https://www.gnu.org/software/make/manual/html_node/index.html#SEC_Contents>

SHELL = /bin/sh

# Important: Local images naming should be in docker-compose naming style

DOCKER_DIR := ./docker

docker_bin := $(shell command -v docker 2> /dev/null)
docker_compose_bin := $(shell command -v docker-compose 2> /dev/null)

# This will output the help for each task. thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# --- [ Development tasks ] -------------------------------------------------------------------------------------------

up:
	$(docker_compose_bin) -f "$(DOCKER_DIR)/docker-compose.yml" --env-file=".env" up --no-recreate

down: ## Stop all started for development containers
	$(docker_compose_bin) -f "$(DOCKER_DIR)/docker-compose.yml" --env-file=".env" down

build: ## Build
	$(docker_compose_bin) -f "$(DOCKER_DIR)/docker-compose.yml" --env-file=".env" build

# restart: ## Restart all or list
# 	$(docker_compose_bin) -f "$(DOCKER_DIR)/docker-compose.yml" --env-file=".env" restart

cmd:
  $(docker_compose_bin) -f "$(DOCKER_DIR)/docker-compose.yml" --env-file=".env" $(runargs)
