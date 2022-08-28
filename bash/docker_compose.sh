#!/bin/bash

cat <<EOF > /home/"${SUDO_USER:-$USER}"/docker/docker-compose.yml
version: '3'

services:
  portainer:
    image: portainer/portainer-ce
    container_name: portainer
    security_opt:
      - no-new-privileges:true
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ./portainer:/data
    ports:
      - 9000:9000
    restart: unless-stopped
    networks:
      - proxy_net

  grafana:
    image: grafana/grafana
    container_name: grafana
    ports:
      - 26502:3000
    volumes:
      - ./grafana:/etc/grafana/provisioning
      - grafana-data:/var/lib/grafana
    restart: unless-stopped
    networks:
      - proxy_net

  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    ports:
      - 9090:9090
    volumes:
      - ./prometheus:/etc/prometheus
      - prometheus-data:/prometheus
    restart: unless-stopped
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
    networks:
      - proxy_net

  cadvisor:
    image: gcr.io/cadvisor/cadvisor:latest
    container_name: cadvisor
    volumes:
      - /:/rootfs:ro
      - /var/run:/var/run:ro
      - /sys:/sys:ro
      - /var/lib/docker/:/var/lib/docker:ro
      - /dev/disk/:/dev/disk:ro
    devices:
      - /dev/kmsg
    restart: unless-stopped
    networks:
      - proxy_net

networks:
  proxy_net:
    external: true

volumes:
  prometheus-data:
    driver: local
  grafana-data:
    driver: local
EOF

docker-compose -f /home/"${SUDO_USER:-$USER}"/docker/docker-compose.yml up -d