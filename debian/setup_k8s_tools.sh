#!/bin/sh

echo "install k8s-cli-tools"
# kubectl
sudo apt-get update && sudo apt-get install -y curl git
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && rm kubectl

# kubectx
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

# helm
wget https://get.helm.sh/helm-v3.4.1-linux-amd64.tar.gz
tar xvf helm-v3.4.1-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin
rm helm-v3.4.1-linux-amd64.tar.gz
rm -rf linux-amd64

# stern
wget https://github.com/wercker/stern/releases/download/1.11.0/stern_linux_amd64
chmod +x stern_linux_amd64
sudo mv stern_linux_amd64 /usr/local/bin/stern

# popeye
wget https://github.com/derailed/popeye/releases/download/v0.10.0/popeye_Linux_x86_64.tar.gz  
mkdir popeye
tar xf popeye_Linux_x86_64.tar.gz --directory=popeye
rm popeye_Linux_x86_64.tar.gz  
chmod +x popeye/popeye
sudo mv popeye/popeye /usr/local/bin/popeye
rm -r popeye