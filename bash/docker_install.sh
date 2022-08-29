#!/bin/bash

yum update
sudo amazon-linux-extras install docker
sudo service docker start
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

sudo usermod -a -G docker ec2-user
sudo chmod +x /usr/local/bin/docker-compose

mkdir -p /etc/docker/{prometheus,cadvisor}
mkdir -p /etc/docker/grafana{dashboards,datasources}