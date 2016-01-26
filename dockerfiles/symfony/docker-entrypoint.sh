#!/bin/bash
set -e

# if command starts with an option, prepend mysqld
if [ "${1:0:1}" = '-' ]; then
	set -- mysqld "$@"
fi

if [ "$1" = 'apache2-foreground' ]; then
    /var/app/console phpci:install --url=http://$PHPCI_HOST --db-host=db --db-name=$DB_ENV_MYSQL_DATABASE --db-user=$DB_ENV_MYSQL_USER --db-pass=$DB_ENV_MYSQL_PASSWORD --admin-name=admin --admin-pass=admin --admin-mail=admin@batandwa.me --no-ansi --no-interaction
fi

exec "$@"
