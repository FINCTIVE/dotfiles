#!/bin/bash

# Parameter check
CLUSTER_NAME=$1
if [[ -z $CLUSTER_NAME ]]; then
  echo "Error: Kind cluster name cannot be empty."
  echo "Usage: $0 <ClusterName>"
  echo "For example, to build kind cluster \"kind-main\":"
  echo "$0 main"
  exit 1
fi

FILE_NAME="local-kind-$CLUSTER_NAME.yaml"

# Ask for moving FILE_NAME to KC_KUBECONFIG_DIR
echo "KC_KUBECONFIG_DIR: $KC_KUBECONFIG_DIR"
read -r -p "Move $FILE_NAME to KC_KUBECONFIG_DIR? (y/n): " MOVE_KUBECONFIG_ANSWER

if [[ "$MOVE_KUBECONFIG_ANSWER" == "y" && -z "$KC_KUBECONFIG_DIR" ]]; then
    echo "Error: KC_KUBECONFIG_DIR is not defined. Please set KC_KUBECONFIG_DIR and try again."
    exit 1
fi

# Delete and recreate the kind cluster
kind delete cluster --name "$CLUSTER_NAME"
kind create cluster --name "$CLUSTER_NAME" --kubeconfig "$FILE_NAME"

# Move the file if user wants to
if [[ "$MOVE_KUBECONFIG_ANSWER" == "y" ]]; then
    mv "$FILE_NAME" "$KC_KUBECONFIG_DIR" || {
      echo "Moving file failed. Check permissions or existence of source/destination."
      exit 1
    }
fi
