#!/bin/bash

yum update
yum install docker.io -y
yum install docker-compose -y
mkdir -p /home/"$USER"/docker/{portainer,grafana,prometheus,cadvisor}
mkdir -p /home/"$USER"/docker/grafana{dashboards,datasources}
groupadd --system dockergroup
useradd --system --no-create-home --group dockergroup,"$USER" -s /bin/false docker
chown -R "$USER":docker /home/"$USER"/docker
usermod -aG docker,adm "$USER"