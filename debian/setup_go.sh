#!/bin/bash

echo "install go 1.18"
if [ -x "$(command -v go)" ]; then
  echo "go is already installed, exit."
  exit 1
fi

go_bin_filename="go1.18.linux-amd64.tar.gz"
wget https://golang.org/dl/${go_bin_filename}
sudo tar -zxvf ${go_bin_filename} -C /usr/local/ >> /dev/null
rm ${go_bin_filename}

# zsh
echo -e "# go1.18 \nexport PATH=/usr/local/go/bin:\${PATH}" | tee -a ~/.zprofile
