#!/bin/sh
sudo apt-get update
sudo apt-get install -y \
  iputils-ping curl wget iputils-ping iproute2 net-tools \
  git make
sudo apt-get install -y \
  zsh autojump ranger fzf silversearcher-ag vim \
  tmux htop ncdu nload jq

# oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# dotfiles
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply FINCTIVE
rm ./bin/chezmoi && find bin -empty -type d -delete