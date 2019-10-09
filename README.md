# Generic Platform - Mail Service

## Overview

Docker image and docker-compose sample configuration to bring up a Mail Sender Service to the Teecke [Docker Generic Platform (GP)](https://github.com/teecke/docker-generic-platform).

## Configuration

The service is formed by one container:

- **mail**: based on [alpine](https://hub.docker.com/_/alpine) docker image with [postfix](https://www.postfix.org) package installed.

## Operation

1. Use the `docker-compose.yml.sample` file as your docker-compose configuration file.

2. Create a docker network called "platform_services" before start the service with `docker network create platform_services`.

3. Create a directory called `mail` to store the mails, queue and spool files.

4. Start with `docker-compose up -d`.

5. Use `mail:25` endpoint within your platform as a mail sender.

6. Manage backups of your files:

   1. Make a backup executing `docker-compose exec mail backup`.
   2. Find the current backup within the `/var/backups/gp/mail/` of the container.
   3. Extract the current backup executing `docker cp $(docker-compose ps -q mail):/var/backups/gp gp`.

7. Stop the platform with `docker-compose stop`.

You can use this docker piece with the [Docker Generic Platform](https://github.com/teecke/docker-generic-platform) project.

## Known issues

None known
