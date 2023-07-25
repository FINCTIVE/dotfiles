#!/bin/bash

# Set the cluster information
KUBE_CLUSTER_NAME="local-cluster"
KUBE_API_SERVER="${KUBERNETES_SERVICE_HOST}:${KUBERNETES_SERVICE_PORT}"

# Set the credentials
KUBE_CA_CERT="/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
KUBE_TOKEN="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)"

# Create the kubeconfig file
kubectl config set-cluster $KUBE_CLUSTER_NAME --server=https://$KUBE_API_SERVER --certificate-authority=$KUBE_CA_CERT --embed-certs=true
kubectl config set-credentials $KUBE_CLUSTER_NAME --token=$KUBE_TOKEN
kubectl config set-context $KUBE_CLUSTER_NAME --cluster=$KUBE_CLUSTER_NAME --user=$KUBE_CLUSTER_NAME
kubectl config use-context $KUBE_CLUSTER_NAME