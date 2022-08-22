#!/bin/bash

IP=$(curl ifconfig.me)

cat <<EOF > /home/"${SUDO_USER:-$USER}"/docker/prometheus/prometheus.yml
global:
  scrape_interval:     15s # By default, scrape targets every 15 seconds.

  # Attach these labels to any time series or alerts when communicating with
  # external systems (federation, remote storage, Alertmanager).
  # external_labels:
  #  monitor: 'codelab-monitor'

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'
    # Override the global default and scrape targets from this job every 5 seconds.
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']

  # Example job for cadvisor
  - job_name: 'cadvisor'
    static_configs:
      - targets: ['cadvisor:8080']
EOF

mkdir /home/"${SUDO_USER:-$USER}"/docker/grafana/datasources

cat <<EOF > /home/"${SUDO_USER:-$USER}"/docker/grafana/datasources/datasource.yml
# config file version
apiVersion: 1

# list of datasources that should be deleted from the database
deleteDatasources:
  - name: Prometheus
    orgId: 1

# list of datasources to insert/update depending
# whats available in the database
datasources:
  # <string, required> name of the datasource. Required
- name: Prometheus
  # <string, required> datasource type. Required
  type: prometheus
  # <string, required> access mode. direct or proxy. Required
  access: proxy
  # <int> org id. will default to orgId 1 if not specified
  orgId: 1
  # <string> url
  url: http://$IP:26503
  # <string> database password, if used
  password:
  # <string> database user, if used
  user:
  # <string> database name, if used
  database:
  # <bool> enable/disable basic auth
  basicAuth:
  # <string> basic auth username
  basicAuthUser:
  # <string> basic auth password
  basicAuthPassword:
  # <bool> enable/disable with credentials headers
  withCredentials:
  # <bool> mark as default datasource. Max one per org
  isDefault:
  # <map> fields that will be converted to json and stored in json_data
  jsonData:
     graphiteVersion: "1.1"
     tlsAuth: true
     tlsAuthWithCACert: true
  # <string> json object of data that will be encrypted.
  secureJsonData:
    tlsCACert: "..."
    tlsClientCert: "..."
    tlsClientKey: "..."
  version: 1
  # <bool> allow users to edit datasources from the UI.
  editable: true
EOF

mkdir /home/"${SUDO_USER:-$USER}"/docker/grafana/dashboards

cat <<EOF > /home/"${SUDO_USER:-$USER}"/docker/grafana/dashboards/dashboard.yml
apiVersion: 1

providers:
- name: 'Prometheus'
  orgId: 1
  type: file
  disableDeletion: false
  editable: true
  updateIntervalSeconds: 10
  allowUiUpdates: true
  options:
    path: /etc/grafana/provisioning/dashboards
    foldersFromFilesStructure: true
EOF