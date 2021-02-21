# Default to showing help section
info: intro help

intro:
	@echo ""
	@echo "                                       ";
	@echo "   (              (                    ";
	@echo " ( )\             )\ )  (   (      (   ";
	@echo " )((_)  (    (   (()/(  )\  )(    ))\  ";
	@echo "((_)_   )\   )\ ) /(_))((_)(()\  /((_) ";
	@echo " | _ ) ((_) _(_/((_) _| (_) ((_)(_))   ";
	@echo " | _ \/ _ \| ' \))|  _| | || '_|/ -_)  ";
	@echo " |___/\___/|_||_| |_|   |_||_|  \___|  ";
	@echo "                                       ";
	@echo "Make your own: http://patorjk.com/software/taag/"
	@echo ""

# ===========================
# Main commands
# ===========================

# Dependencies
install: intro do-composer-install do-assets-install do-assets-build do-database-fresh
update: intro do-composer-update do-assets-update do-assets-build do-database-fresh
reset: intro do-docker-stop do-clean install

# Project
database: intro do-database-fresh

# Frontend
assets: intro do-assets-install do-assets-build
assets-build: intro do-assets-build
assets-watch: intro do-assets-watch

# Tests
tests: intro do-test-unit do-test-report
test-unit: intro do-test-unit

# Development
pre-commit: intro do-lint-staged-files do-commit-intro
codestyle: intro do-cs-ecs
codestyle-fix: intro do-cs-ecs-fix

# Docker
build: intro do-docker-build
start: intro do-docker-start
stop: intro do-docker-stop
logs: intro do-docker-logs
shell: intro do-docker-shell

# ===========================
# Overview of commands
# ===========================

help:
	@echo "\n=== Make commands ===\n"
	@echo "Dependencies"
	@echo "    make install                   Make the project ready for development."
	@echo "    make update                    Update backend and frontend dependencies."
	@echo "    make reset                     Reinstall backend and frontend dependencies."
	@echo "\nProject"
	@echo "    make database                  Set up a (refreshed) database."
	@echo "\nFrontend"
	@echo "    make assets                    Install dependencies and compile the assets."
	@echo "    make assets-build              Compile the assets."
	@echo "    make assets-watch              Compile and watch for changes in the assets."
	@echo "\nTests"
	@echo "    make tests                     Run unit and feature tests."
	@echo "    make test-unit                 Run unit tests."
	@echo "\nDevelopment"
	@echo "    make codestyle                 Check if the codestyle is OK."
	@echo "    make codestyle-fix             Check and fix your messy codestyle."
	@echo "\nDocker"
	@echo "    make start                     Start all containers."
	@echo "    make stop                      Stop all containers."
	@echo "    make shell                     Open shell in the app container."
	@echo "    make logs                      Tail the container logs."

# ===========================
# Recipes
# ===========================

set-unix-ids = USERID=$$(id -u) GROUPID=$$(id -g) \

# Dependencies
do-composer-install:
	@echo "\n=== Installing composer dependencies ===\n"\
	COMPOSER_MEMORY_LIMIT=-1 composer install

do-composer-update:
	@echo "\n=== Updating composer dependencies ===\n"\
	COMPOSER_MEMORY_LIMIT=-1 composer update

# Development
do-commit-intro:
	@echo "\n=== Let's ship it! ===\n"

do-lint-staged-files:
	@node_modules/.bin/lint-staged

do-cs-ecs:
	./vendor/bin/ecs check --config=dev/ecs.php

do-cs-ecs-fix:
	./vendor/bin/ecs check --fix --config=dev/ecs.php

# Docker
do-docker-build:
	@echo "\n=== (Re)building services ===\n"
	@${set-ids} docker-compose --file ops/docker-compose.yml build

do-clean:
	@echo "\n=== 🧹 Cleaning up ===\n"
	@${set-ids} docker-compose --file ops/docker-compose.yml rm -f
	@rm -rf src/vendor/*
	@rm -rf src/node_modules/*

do-docker-start:
	@echo "\n=== Starting containers ===\n"
	@${set-ids} docker-compose --file ops/docker-compose.yml up -d --remove-orphans

do-docker-stop:
	@echo "\n=== Stopping containers ===\n"
	@${set-ids} docker-compose --file ops/docker-compose.yml stop

do-docker-logs:
	@echo "\n=== Watch logs ===\n"
	@${set-ids} docker-compose --file ops/docker-compose.yml logs -f --tail 5

do-docker-shell:
	@echo "\n=== Start shell in app container ===\n"
	@${set-ids} docker-compose --file ops/docker-compose.yml exec app sh

# Project
do-database-fresh:
	@echo "\n=== Setting up a fresh database ===\n"
	@echo "TODO: use your method of choice"

# Frontend
do-assets-install:
	@echo "\n=== Installing npm dependencies ===\n"
	npm install

do-assets-update:
	@echo "\n=== Updating npm dependencies ===\n"
	npm update

do-assets-build:
	@echo "\n=== Running npm development ===\n"
	npm run dev

do-assets-watch:
	@echo "\n=== Running npm watch ===\n"
	npm run watch

# Tests
do-test-unit:
	@echo "\n=== Running unit tests ===\n"
	vendor/bin/phpunit

do-test-report:
	@echo "\n=== Click the link below to see the test coverage report ===\n"
	@echo "report/index.html"
