# install
brew install watch

# init dotfiles
chezmoi init git@github.com:FINCTIVE/dotfiles.git
chezmoi apply
fish -c "curl -sL https://git.io/fisher | source && fisher update"

echo "chezmoi diff => diff"
echo "chezmoi cd => go to the dotfiles folder"
echo "chezmoi apply => dotfiles folder to computer settings"
echo "chezmoi re-add => computer settings to dotfiles folder"
echo "note: push dotfiles folder manually"
