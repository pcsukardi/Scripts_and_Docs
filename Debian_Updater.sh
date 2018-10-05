#!/bin/bash

# This updates the repository list.
sudo apt-get update 

# This brings the system up to date with an upgrade.
sudo apt-get upgrade -y

# This will resolve any missed dependencies after the upgrade.
sudo apt-get install -f

# This will clean up any broken dependencies or deprecated packages.
sudo apt autoremove -y

#This upgrades the new distributed packages after the update and system upgrade.
sudo apt-get dist-upgrade -y

exit 0
