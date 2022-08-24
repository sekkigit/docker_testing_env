#!/bin/bash

chmod +x ./bash/docker_install.sh
chmod +x ./bash/prometheus.sh
chmod +x ./bash/docker_compose.sh

bash ./bash/docker_install.sh
docker network create proxy_net
bash ./bash/prometheus.sh
cp ./json/* /home/"$USER"/docker/grafana/dashboards/
bash ./bash/docker_compose.sh