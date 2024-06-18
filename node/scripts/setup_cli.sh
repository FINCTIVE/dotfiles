#!/bin/sh
echo "install cli tools"

sudo apt-get update
sudo apt-get install -y --no-install-recommends \
  procps lsof \
  iproute2 net-tools iputils-ping netcat-openbsd \
  ca-certificates curl wget \
  htop ncdu nload tcpdump termshark \
  git zsh vim \
  zoxide nnn fzf jq

# zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/Aloxaf/fzf-tab ~/.oh-my-zsh/custom/plugins/fzf-tab
curl -sSL https://starship.rs/install.sh | sh -s -- --yes

# dotfiles
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply FINCTIVE
rm ./bin/chezmoi && find bin -empty -type d -delete
