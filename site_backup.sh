#!/bin/bash

mysqldump -u wpuser -ppassword12 wordpress > /var/www/html/wordpress/"db_backup.sql.$(date)"

rsync -azh /var/www/html/wordpress admin@173.220.39.125:/share/homes/admin/

exit 0
