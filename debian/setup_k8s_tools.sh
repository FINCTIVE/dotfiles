#!/bin/sh

echo "install k8s-cli-tools"
sudo apt-get update && sudo apt-get install -y curl git

# kubectl
sudo apt-get install -y ca-certificates
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# kubectx
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

# helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm ./get_helm.sh

# popeye
ARCH=$(uname -m)
case $ARCH in
  aarch64) ARCH="arm64";;
  x86_64) ARCH="x86_64";;
esac
wget https://github.com/derailed/popeye/releases/download/v0.10.0/popeye_Linux_${ARCH}.tar.gz  
mkdir popeye
tar xf popeye_Linux_${ARCH}.tar.gz --directory=popeye
rm popeye_Linux_${ARCH}.tar.gz
sudo mv popeye/popeye /usr/local/bin/popeye
rm -r popeye

# stern
ARCH=$(uname -m)
case $ARCH in
  aarch64) ARCH="arm64";;
  x86_64) ARCH="x86_64";;
esac
wget https://github.com/stern/stern/releases/download/v1.22.0/stern_1.22.0_linux_${ARCH}.tar.gz
mkdir stern
tar xf stern_1.22.0_linux_${ARCH}.tar.gz --directory=stern
rm stern_1.22.0_linux_${ARCH}.tar.gz
sudo mv stern/stern /usr/local/bin/stern
rm -r stern