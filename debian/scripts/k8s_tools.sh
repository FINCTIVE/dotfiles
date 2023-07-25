#!/bin/sh
echo "install k8s ops tools"

sudo apt-get update && sudo apt-get install -y curl git

# kubectl
sudo apt-get install -y ca-certificates
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# kubie
ARCH=$(uname -m)
case $ARCH in
  aarch64) ARCH="linux-arm64";;
  x86_64) ARCH="linux-amd64";;
esac
wget https://github.com/sbstp/kubie/releases/download/v0.19.1/kubie-${ARCH}
chmod +x kubie-${ARCH}
sudo mv kubie-${ARCH} /usr/local/bin/kubie

# helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm ./get_helm.sh
