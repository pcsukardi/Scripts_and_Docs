#!/bin/bash

# This adds the openjdk11 repo as is required by alot of things and Ubuntu comes with 8.
sudo add-apt-repository ppa:openjdk-r/ppa -y

# This updates the repository list.
sudo apt-get update 

# Install openssh server.
sudo apt-get install openssh-server -y 

# Add docker GPG key.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add docker repo.
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y
   
# Update the repos.
sudo apt-get update

# This installs openjdk 11.
sudo apt install openjdk-11-jdk -y

# This installs docker.
sudo apt-get install docker-ce -y

# This brings the system up to date with an upgrade.
sudo apt-get upgrade -y

# This will resolve any missed dependencies after the upgrade.
sudo apt-get install -f

# This will clean up any broken dependencies or deprecated packages.
sudo apt autoremove -y

#This upgrades the new distributed packages after the update and system upgrade.
sudo apt-get dist-upgrade -y

# Create the docker group.
sudo groupadd docker

# Add your user to the docker group.
sudo usermod -aG docker $USER

# Enable docker at startup.
sudo systemctl enable docker

exit 0
