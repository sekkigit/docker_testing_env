# Docker testing environment Setup
### Made for Ubuntu 22.04 LTS and 20.04


#### This script is intended to quickly set up a Docker environment for testing containers and monitor them with Grafana.

<p align="right">COPY
</p>

```
#!/bin/bash

sudo amazon-linux-extras install git
git clone https://github.com/sekkigit/docker_testing_env.git install 
cd install 
sudo bash install.sh
```

#### Install: 

| Program | Description |
| --- | --- |
| Docker | Software platform that simplifies the process of building, running, managing and distributing applications. |
| Docker-compose | Tool to help you define and share multi-container applications. |
| Portainer | Deploy, configure and secure your container environments. |
| Grafana | Analytics & monitoring solution. |
| Prometheuse | Monitoring system with a dimensional data model. |
| cAdvisor | Performance characteristics of the running containers. |

<details><summary>Warning</summary>
<p>

#### ⚠️ Please beware that products can change over time.

I do my best to keep up with the latest changes and releases, but please understand that this won’t always be the case.

</p>
</details>
