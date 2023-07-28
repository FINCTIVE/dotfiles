#!/bin/sh
echo "install cli tools"

sudo apt-get update
sudo apt-get install -y --no-install-recommends \
  procps lsof ca-certificates \
  iproute2 net-tools iputils-ping curl wget netcat-openbsd tcpdump \
  git make \
  htop ncdu nload termshark \
  tmux zsh neovim \
  zoxide nnn fzf jq silversearcher-ag

# zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/Aloxaf/fzf-tab ~/.oh-my-zsh/custom/plugins/fzf-tab
curl -sSL https://starship.rs/install.sh | sh -s -- --yes

# dotfiles
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply FINCTIVE
rm ./bin/chezmoi && find bin -empty -type d -delete
