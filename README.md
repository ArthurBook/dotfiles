## Setup
load plug-vim:
```bash
brew install neovim
brew install cmake
brew install node 

## Linting and such
pip install black flake8 pylint mypy

## Syntax highlighting
npm install -g pyright

mkdir -p ~/.config/nvim

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

```bash
~/.config/nvim/plugged/YouCompleteMe/install.py --verbose
```
