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

# Install k3s agent
K3S_URL="https://192.168.56.10:6443" K3S_TOKEN=$(cat /vagrant/token) /tmp/k3s-install.sh agent