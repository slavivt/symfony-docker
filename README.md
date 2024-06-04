# Symfony Docker

A [Docker](https://www.docker.com/)-based installer and runtime for the [Symfony](https://symfony.com) web framework.

## Getting Started

1. If not already done, [install Docker Compose](https://docs.docker.com/compose/install/)
2. Run `docker compose build --no-cache` to build fresh images
3. Run `docker compose up --pull always -d --wait` to set up and start a fresh Symfony project
4. Open `https://localhost:8080` in your web browser
5. Run `docker compose down --remove-orphans` to stop the Docker containers.

## Configuration
### Symfony
There is .env file which can be overriden by .env.local file. [Symfony Configuration](https://symfony.com/doc/current/configuration.html#selecting-the-active-environment)
By default Symfony application is in prod mode. If you want to run it in dev mode you have to add .env.local file with following content:
```
APP_ENV=dev
```

### Docker
Docker compose can is configured with composer.yaml file. It can be overriden with composer.override.yaml file.
By default docker compose use prod build. If you want to use the dev build you have to add composer.override.yaml with following content:
```
services:
  php:
    build:
      target: php_fpm_dev
    command: >
      bash -c "cd /var/www/html
      && composer install --no-cache --no-scripts --no-progress
      && php-fpm"
    environment:
      APP_ENV: dev
      APP_DEBUG: true
      XDEBUG_MODE: off
```

## Features

* Production and development ready
* Native [XDebug](https://xdebug.org/) integration
* [Symfony Profiler](https://symfony.com/doc/current/profiler.html)
* [Symfony Maker](https://symfony.com/bundles/SymfonyMakerBundle/current/index.html) 
