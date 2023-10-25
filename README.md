## Setup
load plug-vim:
```bash
brew install neovim
brew install cmake

mkdir -p ~/.config/nvim
touch ~/.config/nvim/init.vim

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

~/.config/nvim/plugged/YouCompleteMe/install.py --verbose
```
