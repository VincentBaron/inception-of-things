#!/bin/bash

# Install required packages
apt-get update
apt-get install -y curl wget

# Download k3s binary directly
wget -q https://github.com/k3s-io/k3s/releases/download/v1.27.8%2Bk3s1/k3s -O /usr/local/bin/k3s
chmod +x /usr/local/bin/k3s

# Download the installation script
wget -q https://get.k3s.io -O /tmp/k3s-install.sh
chmod +x /tmp/k3s-install.sh

# Install k3s server
INSTALL_K3S_EXEC="server --node-ip=192.168.56.10" /tmp/k3s-install.sh

# Make sure kubectl is set up for the vagrant user
sudo mkdir -p /home/vagrant/.kube
sudo cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
sudo chown -R vagrant:vagrant /home/vagrant/.kube/config

# Get the token for the worker nodes
TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)

# Store the token for the workers to use
echo $TOKEN > /vagrant/token