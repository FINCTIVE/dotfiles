#!/bin/bash
set -ex

# Parameter check
ISTIO_PATH=$1
if [[ -z $ISTIO_PATH ]]; then
  echo "Error: ISTIO_PATH cannot be empty."
  echo "Usage: $0 <ISTIO_PATH>"
  exit 1
fi

cd $ISTIO_PATH
echo "pwd:" $(pwd)

# https://istio.io/latest/docs/setup/getting-started/#download

./bin/istioctl install --set profile=demo -y

kubectl label namespace default istio-injection=enabled
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
kubectl apply -f samples/addons
kubectl rollout status deployment/kiali -n istio-system
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml

echo https://istio.io/latest/docs/examples/bookinfo/
