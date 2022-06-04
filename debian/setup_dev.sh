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

# Go
go_bin_filename="go1.18.linux-amd64.tar.gz"
wget https://golang.org/dl/${go_bin_filename}
sudo tar -zxvf ${go_bin_filename} -C /usr/local/
rm ${go_bin_filename}
echo "export PATH=/usr/local/go/bin:${PATH}" | sudo tee /etc/profile.d/go.sh
source /etc/profile.d/go.sh
go version
