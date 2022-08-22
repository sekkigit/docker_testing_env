#!/bin/bash

SPLIT=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)

apt update
clear

bash ./bash/docker_install.sh &> /dev/null

docker network create proxy_net

bash ./bash/prometheus.sh &> /dev/null
cp ./json/* /home/"${SUDO_USER:-$USER}"/docker/grafana/dashboards/
bash ./bash/docker_compose.sh
bash ./bash/log.sh
cat log.txt