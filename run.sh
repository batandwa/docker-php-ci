#!/bin/bash
#COMPOSE_FILE=${COMPOSE_FILE:?"docker-compose-dev.yml"}
if [ -z "${COMPOSE_FILE}" ]; then export COMPOSE_FILE="docker-compose-dev.yml"; fi
docker-compose up -d
#docker cp `basename $PWD`:/etc/apache2/mods-available/rewrite.load server_conf/rewrite.load
#docker cp `basename $PWD`:/etc/apache2/sites-available/000-default.conf server_conf/000-default.conf
#docker-compose up -d --force-recreate
docker exec `basename $PWD` a2enmod rewrite
docker restart `basename $PWD`
docker exec -it `basename $PWD` sh -c 'echo "*  *  *  *  *  /var/app/console phpci:run-builds" >> /etc/cron.d/phpci'
