#!/bin/bash

if ! kubectl get namespaces | grep -q 'locust'; then
    kubectl create namespace locust
fi

if kubectl -n locust get configmap locustfile-configmap &>/dev/null; then
    kubectl -n locust delete configmap locustfile-configmap
fi

kubectl -n locust create configmap locustfile-configmap --from-file=locustfile.py
