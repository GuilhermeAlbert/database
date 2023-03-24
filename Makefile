include .makefile.env
export

.PHONY: nop
nop:
	@echo "Please pass a target you want to run"

.PHONY: install
install:
	./install.sh

.PHONY: up
up:
	${DOCKER_COMPOSE_COMMAND_PREFIX} up -d

.PHONY: build
build:
	${DOCKER_COMPOSE_COMMAND_PREFIX} up -d --build

.PHONY: down
down:
	${DOCKER_COMPOSE_COMMAND_PREFIX} down

.PHONY: bash
bash:
	${DOCKER_COMPOSE_COMMAND_PREFIX} exec app bash

.PHONY: test
test:
	${DOCKER_COMPOSE_COMMAND_PREFIX} exec app ./vendor/bin/phpunit

.PHONY: migrate
migrate:
	${DOCKER_COMPOSE_COMMAND_PREFIX} exec app php artisan migrate

.PHONY: status
status:
	${DOCKER_COMPOSE_COMMAND_PREFIX} exec app php artisan migrate:status

.PHONY: rollback
rollback:
	${DOCKER_COMPOSE_COMMAND_PREFIX} exec app php artisan migrate:rollback

.PHONY: seed
seed:
	${DOCKER_COMPOSE_COMMAND_PREFIX} exec app php artisan db:seed

.PHONY: restore
restore:
	docker exec -i ${DATABASE_CONTAINER_NAME} mysql -uroot -proot veggi < dump.sql

.PHONY: dump
dump:
	docker exec -i ${DATABASE_CONTAINER_NAME} mysqldump -uroot -proot veggi > exported-dump.sql

.PHONY: mysql
mysql:
	${DOCKER_COMPOSE_COMMAND_PREFIX} exec mysql bash