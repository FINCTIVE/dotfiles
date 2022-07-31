#!/bin/sh
echo "init everything: https://github.com/FINCTIVE/dotfiles/tree/main/debian"

cd $HOME

sudo apt-get update
sudo apt-get install -y curl

GITHUB_DIR_PATH="https://raw.githubusercontent.com/FINCTIVE/dotfiles/main/debian/"
curl ${GITHUB_DIR_PATH}setup_code_server.sh | sh
curl ${GITHUB_DIR_PATH}setup_dev.sh | sh
curl ${GITHUB_DIR_PATH}setup_docker.sh | sh
curl ${GITHUB_DIR_PATH}setup_go.sh | sh
curl ${GITHUB_DIR_PATH}setup_k8s_tools.sh | sh
curl ${GITHUB_DIR_PATH}setup_kind.sh | sh