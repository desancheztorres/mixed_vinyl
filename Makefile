# To get the current directory in Linux, Mac or Windows
current-dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
SHELL = /bin/sh
RUN_PHP := docker-compose exec php

start:
	@docker-compose up -d

restart: stop start

stop:
	@docker-compose down

rebuild:
	@docker-compose up -d --build

exec:
	docker-compose exec php bash

.PHONY: build
build: composer/install

composer/install: ACTION=install --ignore-platform-reqs
composer/update: ACTION=update
composer/require: ACTION=require $(module)
composer composer/install composer/update composer/require:
	$(RUN_PHP) composer $(ACTION)