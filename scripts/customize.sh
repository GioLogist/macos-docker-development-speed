#!/usr/bin/env bash


############################################################
###################### INSTALL DOCKER ######################
############################################################

echo -e "Installing Docker...\n"

echo -e "Set up the repository\n"

echo -e "Update the apt package index and install packages to allow apt to use a repository over HTTPS:\n"
sudo apt-get update
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

echo -e "Add Docker’s official GPG key:\n"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo -e "Setup stable repository\n"
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

echo -e "Install Docker engine\n"

echo -e "Update the apt package index, and install the latest version of Docker Engine and containerd\n"
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io


############################################################
################### POST INSTALL DOCKER ####################
############################################################

echo -e "Docker Post-installation steps for linux\n"

echo -e "Create the docker group.\n"
sudo groupadd docker

echo -e "Add your user to the docker group.\n"
sudo usermod -aG docker $USER

# Specific to vagrant
echo -e "Add vagrant user to the docker group.\n"
sudo usermod -aG docker vagrant

echo -e "Configure docker to start on boot\n"
sudo systemctl enable docker


############################################################
################## INSTALL DOCKER COMPOSE ##################
############################################################

echo -e "Installing Docker Compose...\n"

echo -e "Download the current stable release of Docker Compose:\n"
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

echo _e "Apply executable permissions to the binary:\n"
sudo chmod +x /usr/local/bin/docker-compose
