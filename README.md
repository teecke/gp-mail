# Generic Platform - Mail Service

## Overview

Teecke Generic Platform Mail Service.

Docker-ompose simple configuration to bring up the Mail service to the Generic Platform.

## Configuration

The service is formed by one container:

- **mail**: based on [alpine](https://hub.docker.com/_/alpine) docker image with [postfix](https://www.postfix.org) package installed.

## Operation

You must create a network called "platform_services" before start the services.

```console
docker network create platform_services
```

Then you can start the service with `docker-compose up -d` and stop it with `docker-compose stop` commands.

There is one volume created. The ongoing mail data are placed on this volume, so never delete it.

```console
$ docker volume ls|grep "mail\|VOLUME"
DRIVER              VOLUME NAME
local               gp-mail_mail
```

There are also two tasks `cleanup` and `backup` that you can execute as stand-alone

```console
$ docker-compose exec mail cleanup

[...]

$ docker-compose exec mail backup
```

...or using [Teecke Generic Platform](https://github.com/teecke/generic-platform) project.

The backup data will be stored in the `/var/backups/gp/mail/` directory of the container. You can copy the backup files with a simple "docker cp" command `docker cp $(docker-compose ps -q mail):/var/backups/gp gp`

## Known issues

None known
