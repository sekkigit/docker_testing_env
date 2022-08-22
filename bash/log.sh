#!/bin/bash

SPLIT=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)

echo "SPLIT" > log.txt
echo "Docker is $(systemctl is-enabled docker) and $(systemctl is-active docker)." > log.txt
echo "Docker system prune automated." > log.txt
echo "SPLIT" > log.txt
echo "Service:    PORT" > log.txt
echo "SPLIT" > log.txt
echo "portainer:  26501" > log.txt
echo "Grafana:    26502" > log.txt
echo "Prometheus: 26503" > log.txt
echo "SPLIT" > log.txt