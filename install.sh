#!/bin/bash

bash ./bash/docker_install.sh
docker network create proxy_net
bash ./bash/prometheus.sh
cp ./json/* /home/"$USER"/docker/grafana/dashboards/
bash ./bash/docker_compose.sh