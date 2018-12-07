#!/bin/bash

User={user_name}
Password={password_of_user}
Database={database_name}
Path={directory_path_to_backup}
Serveraddress={destination_ip_address}

mysqldump -u $User -p$Password $Database > $Path/"db_backup.sql.$(date)"

rsync -azh $Path user@$Serveraddress:/share/homes/admin/

exit 0
