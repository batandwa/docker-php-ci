#!/bin/bash

HOST="localhost"

databases=`mysql -u $MYSQL_USER -h $HOST -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`

for db in $databases; do
  if [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != _* ]] ; then
    echo "Dumping database: $db"
    mysqldump -u $MYSQL_USER -h $HOST -p$MYSQL_PASSWORD --databases $db | gzip -9 > /backups/${db}_`date +%Y%m%d_%H%M%S`.sql.gz
  fi
done
