#!/bin/bash

primera_ip=$(hostname -I | cut -d ' ' -f 1)
echo "Para configurar: http://$primera_ip:8080"

url_code_py="https://raw.githubusercontent.com/emericjimenez/demos/main/basic_kafka/code.py"
url_docker_cp="https://raw.githubusercontent.com/emericjimenez/demos/main/basic_kafka/docker-compose.yml"
url_fluent="https://raw.githubusercontent.com/emericjimenez/demos/main/basic_kafka/fluent-bit.conf"
code_py="code.py"
docker_cp="docker-compose.yml"
fluent="fluent-bit.conf"
dir_kafka=~/kafka

#-------------INSTALL FLUENT
curl https://raw.githubusercontent.com/fluent/fluent-bit/master/install.sh | sh
#----------------INSTALL DOCKER
echo Update 1
sudo apt update -y
echo install docker
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo rm -f  /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y
apt-cache policy docker-ce
sudo apt install -y docker-ce
#sudo systemctl status docker
sudo apt install -y docker-compose

#------------ INSTALL PIP
sudo apt install -y python3-pip
pip install --user kafka-python
pip install --user psycopg2-binary

mkdir $dir_kafka
cd $dir_kafka

cp $url_code_py "$dir_kafka/$code_py"
cp $url_docker_cp "$dir_kafka/$docker_cp"
cp $url_fluent "$dir_kafka/$fluent"

#----------->DOCKER COMPOSE
sudo docker-compose up

