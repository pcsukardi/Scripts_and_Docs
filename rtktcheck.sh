#!/bin/bash

(

#This checks the current version of rkhunter.
sudo /usr/bin/rkhunter --versioncheck

#This updates the rkhunter definitions.
sudo /usr/bin/rkhunter --update > /dev/null

#This runs a rootkit check on the system.
sudo /usr/bin/rkhunter --cronjob --report-warnings-only

sudo /usr/bin/rkhunter --check -sk | grep warning

) | mail -s 'rkhunter Daily Run (ServerHostname)' user@example.com

exit 0

