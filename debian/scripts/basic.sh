#!/bin/sh
echo "install cli tools"

sudo apt-get update
sudo apt-get install -y \
  iputils-ping curl wget iproute2 net-tools procps tcpdump \
  git make
sudo apt-get install -y \
  tmux zsh vim \
  zoxide nnn fzf \
  jq silversearcher-ag \
  htop ncdu nload

# zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/Aloxaf/fzf-tab ~/.oh-my-zsh/custom/plugins/fzf-tab
curl -sSL https://starship.rs/install.sh | sh -s -- --yes

# dotfiles
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply FINCTIVE
rm ./bin/chezmoi && find bin -empty -type d -delete
