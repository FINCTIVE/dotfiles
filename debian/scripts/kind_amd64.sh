#!/bin/sh
echo "install kind"

if [ -x "$(command -v kind)" ]; then
  echo "kind is already installed, exit."
  exit 1
fi

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.12.0/kind-linux-amd64
chmod +x ./kind
sudo install kind /usr/local/bin/kind && rm ./kind

cat > kind-config.yaml <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
  apiServerAddress: "0.0.0.0"
  apiServerPort: 4001
nodes:
- role: control-plane
- role: worker
- role: worker
EOF

echo "To launch a cluster:"
echo "$ kind create cluster --config kind-config.yaml"
