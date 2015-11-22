#!/bin/bash

runincontainer() {
  docker exec `basename $PWD` bash -c "$@"
}

chmod -Rf 0777 /var/app/PHPCI/build
dock='docker exec `basename $PWD`'

# Install Grunt
docker exec `basename $PWD` apt-get update
docker exec `basename $PWD` apt-get install --yes curl
docker exec `basename $PWD` curl --silent --location https://deb.nodesource.com/setup_4.x | sudo bash -
docker exec `basename $PWD` apt-get install --yes nodejs build-essential
docker exec `basename $PWD` npm install -g grunt-cli

# Install SASS
docker exec `basename $PWD` apt-get install --yes ruby
docker exec `basename $PWD` gem install sass

docker exec `basename $PWD`-db mkdir /var/log/mysql -p
docker exec `basename $PWD`-db touch /var/log/mysql/mysql_queries.log
docker exec `basename $PWD`-db chown mysql:mysql /var/log/mysql/ -Rf
docker exec `basename $PWD` a2enmod rewrite
docker exec `basename $PWD` sh -c 'echo "*  *  *  *  *  /var/app/console phpci:run-builds" >> /etc/cron.d/phpci'

docker-compose restart

docker exec `basename $PWD` bash -c 'cd /var/app && ./composer.phar --ignore-platform-reqs install'
docker exec `basename $PWD` bash -c 'cd /var/app && ./composer.phar --ignore-platform-reqs update'

docker exec `basename $PWD` mv /var/app/PHPCI/config.yml /var/app/PHPCI/config.yml.`date +%Y%m%d%H%M%S`
docker exec `basename $PWD` bash -c 'cd /var/app && ./console phpci:install --url=http://$VIRTUAL_HOST --db-host=db --db-name=phpci6 --db-user=root --db-pass=doinkydoinkwalking --admin-name=admin --admin-pass=doinkydoinkwalking --admin-mail=admin@batandwa.me --no-ansi --no-interaction'

docker exec `basename $PWD` touch /var/.build-tool-set-up



#SET global general_log_file='/var/log/mysql/mysql.log'; SET global general_log = on; SET global log_output = 'file'