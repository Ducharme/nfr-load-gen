
# Install

## Docker

[Docker engine install ubuntu](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script)
Install using the convenience script
```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh
```
[Docker engine postinstall ubuntu](https://docs.docker.com/engine/install/linux-postinstall/) to run docker without admin rights
```
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world
```
