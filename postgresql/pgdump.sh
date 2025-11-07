#!/bin/bash
PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

PGPASSWORD="123123123"
export PGPASSWORD
pathB=/mnt/backup/dumps

find $pathB \( -name "*-1[^5].*" -o -name "*-[023]?.*" \) -ctime +7 -delete

for dbname in `echo "SELECT datname FROM pg_database;" | psql | tail -n +3 | head -n -2 | egrep -v 'template0|template1|postgres'`; do
    pg_dump -h "x.x.x.x" -p "yyyyy" -U "postgres" $dbname | gzip > $pathB/$dbname-$(date "+%Y-%m-%d").sql.gz
done;

unset PGPASSWORD
