#!/bin/bash
dockeryml="https://raw.githubusercontent.com/emericjimenez/demos/main/basic_docker/docker-compose.yml"
Dockerfile="https://raw.githubusercontent.com/emericjimenez/demos/main/basic_docker/Dockerfile"
main="https://raw.githubusercontent.com/emericjimenez/demos/main/basic_docker/main.py"
requirements="https://raw.githubusercontent.com/emericjimenez/demos/main/basic_docker/requirements.txt"
index="https://raw.githubusercontent.com/emericjimenez/demos/main/basic_docker/index.php"

echo MKDIR
mkdir docker00
cd docker00
wget $index
wget $dockeryml
wget $Dockerfile
wget $main
wget $requirements


echo Update 1
sudo apt update

echo install docker
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

sudo rm -f  /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
apt-cache policy docker-ce
sudo apt install -y docker-ce
#sudo systemctl status docker
sudo apt install -y docker-compose

ip_address=$(hostname -I)
ip=($ip_address)
echo "$ip">ip.txt

sudo docker-compose up &
echo "page link http://$ip"
