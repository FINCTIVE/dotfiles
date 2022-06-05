#!/bin/bash
go_bin_filename="go1.18.linux-amd64.tar.gz"
wget https://golang.org/dl/${go_bin_filename}
sudo tar -zxvf ${go_bin_filename} -C /usr/local/
rm ${go_bin_filename}
# todo: a better place to set $PATH
# bash
echo "export PATH=/usr/local/go/bin:${PATH}" | sudo tee /etc/profile.d/go.sh
# zsh
# todo
# check
source /etc/profile.d/go.sh
go version