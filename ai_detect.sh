#!/bin/bash
userDir=~/dockerai
echo MKDIR
mkdir $userDir
cd $userDir
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

requirements="https://raw.githubusercontent.com/emericjimenez/demos/main/ai_detect/requirements.txt"
xg_model="https://raw.githubusercontent.com/emericjimenez/demos/main/ai_detect/xg_model.pkl"
main="https://raw.githubusercontent.com/emericjimenez/demos/main/ai_detect/main.py"
index="https://raw.githubusercontent.com/emericjimenez/demos/main/ai_detect/index.php"
dockeryml="https://raw.githubusercontent.com/emericjimenez/demos/main/ai_detect/docker-compose.yml"
docker="https://raw.githubusercontent.com/emericjimenez/demos/main/ai_detect/Dockerfile"
userDir=~/dockerai

ip_address=$(hostname -I)
ip=($ip_address)
echo "$ip">ip.txt

wget $requirements
wget $xg_model
wget $main
wget $index
wget $docker
wget $dockeryml
sudo docker-compose up
echo "page link http://$ip"