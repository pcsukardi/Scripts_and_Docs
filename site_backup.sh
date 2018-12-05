#!/bin/bash

mysqldump -u {userhere} -p{passwordhere} {databasehere} > /var/www/html/wordpress/"db_backup.sql.$(date)"

rsync -azh /var/www/html/wordpress {user@serveraddresshere}:/share/homes/admin/

exit 0
