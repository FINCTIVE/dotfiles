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

# https://istio.io/latest/docs/setup/additional-setup/config-profiles/

./bin/istioctl install --set profile=default -y
kubectl apply -f samples/addons
# Apply Gateway CR to open the listening port.
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
kubectl -n istio-system patch hpa istio-ingressgateway --type=json -p='[{"op": "replace", "path": "/spec/maxReplicas", "value": 1}]' 