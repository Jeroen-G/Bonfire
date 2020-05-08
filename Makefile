# ===========================
# Default: help section
# ===========================

info: intro do-show-commands

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

install: intro do-composer-install do-assets-install do-database-fresh

# Backend
database: intro do-database-fresh

# Frontend
assets: intro do-assets-install do-assets-build
assets-build: intro do-assets-build
assets-watch: intro do-assets-watch

# Tests
tests: intro do-test-unit do-test-report
test-unit: intro do-test-unit

# Codestyle
pre-commit: intro do-lint-staged-files do-commit-intro
codestyle: intro do-cs-ecs
codestyle-fix: intro do-cs-ecs-fix

# ===========================
# Recipes
# ===========================

do-show-commands:
	@echo "\n=== Make commands ===\n"
	@echo "Project commands:"
	@echo "    make install                   Make the project ready for development."
	@echo "    make database                  Set up a (refreshed) database."
	@echo "\nBuild assets:"
	@echo "    make assets                    Install dependencies and compile the assets."
	@echo "    make assets-build              Compile the assets."
	@echo "    make assets-watch              Compile and watch for changes in the assets."
	@echo "\nTests:"
	@echo "    make tests                     Run unit and feature tests."
	@echo "    make test-unit                 Run unit tests."

do-composer-install:
	@echo "\n=== Installing composer dependencies ===\n"\
	COMPOSER_MEMORY_LIMIT=-1 composer install

do-database-fresh:
	@echo "\n=== Setting up a fresh database ===\n"
	@echo "TODO: use your method of choice"

do-assets-install:
	@echo "\n=== Installing npm dependencies ===\n"
	npm install

do-assets-build:
	@echo "\n=== Running npm development ===\n"
	npm run dev

do-assets-watch:
	@echo "\n=== Running npm watch ===\n"
	npm run watch

do-test-unit:
	@echo "\n=== Running unit tests ===\n"
	vendor/bin/phpunit

do-test-report:
	@echo "\n=== Click the link below to see the test coverage report ===\n"
	@echo "report/index.html"

do-commit-intro:
	@echo "\n=== Let's ship it! ===\n"

do-lint-staged-files:
	@node_modules/.bin/lint-staged

do-cs-ecs:
	./vendor/bin/ecs check --config=easy-coding-standard.yml

do-cs-ecs-fix:
	./vendor/bin/ecs check --fix --config=easy-coding-standard.yml
