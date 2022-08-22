#!/bin/bash

apt update &> /dev/null

bash ./bash/docker_install.sh &> /dev/null

docker network create proxy_net

bash ./bash/prometheus.sh &> /dev/null
cp ./json/* /home/"${SUDO_USER:-$USER}"/docker/grafana/dashboards/
bash ./bash/docker_compose.sh