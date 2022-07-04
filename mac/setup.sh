# install brew
# setup env variables


# install
brew install \ 
  watch \
  chezmoi fzf autojump ranger the_silver_searcher \
  tmux htop ncdu nload jq 

# oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# init dotfiles
chezmoi init git@github.com:FINCTIVE/dotfiles.git
chezmoi init https://github.com/FINCTIVE/dotfiles.git
chezmoi apply

echo "chezmoi diff => diff"
echo "chezmoi cd => go to the dotfiles folder"
echo "chezmoi apply => dotfiles folder to computer settings"
echo "chezmoi re-add => computer settings to dotfiles folder"
echo "note: push dotfiles folder manually"
