#!/bin/sh
echo "install cli tools"

sudo apt-get update
sudo apt-get install -y \
  iputils-ping curl wget iputils-ping iproute2 net-tools procps \
  git make
sudo apt-get install -y \
  zsh autojump ranger fzf silversearcher-ag vim \
  tmux htop ncdu nload jq

# oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/Aloxaf/fzf-tab ~/.oh-my-zsh/custom/plugins/fzf-tab
curl -sS https://starship.rs/install.sh | sh

# dotfiles
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply FINCTIVE
rm ./bin/chezmoi && find bin -empty -type d -delete
