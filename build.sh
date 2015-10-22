#!/bin/bash

docker exec -it `basename $PWD` /var/app/console phpci:run-builds
#docker exec -it `basename $PWD` sh -c 'echo "*  *  *  *  *  /var/app/console phpci:run-builds" >> /etc/cron.d/phpci'