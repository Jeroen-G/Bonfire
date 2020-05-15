# Bonfire [🔥](https://www.dumpert.nl/item/7153219_dce8872e)

Boilerplate for new projects.

## Requirements

- PHP
- Make

## Installation

Replace `<project>` with the name of your project.

`git clone --depth 1 git@github.com:Jeroen-G/Bonfire.git bonfire && cp -a bonfire/. <project> && rm -rf bonfire/`

To be able to run all make commands:

`composer require --dev symplify/easy-coding-standard phpunit/phpunit`

`npm install --save-dev husky lint-staged`

## Configuration

Add the following to your package.json:
```json
"husky": {
    "hooks": {
        "pre-commit": "make pre-commit"
    }
},
"lint-staged": {
    "*.php": [
        "php vendor/bin/ecs check --fix --config=easy-coding-standard.yml"
    ]
}
```
