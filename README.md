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

## Copy init.lua to nvim startup dir  
mkdir -p ~/.config/nvim
make update_config


## Install plug
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## Then, run vimscript: (in nvim and press : and type
```vimscript
:PackerInstall
```

## Finally, compile YCM
```bash
~/.local/share/nvim/site/pack/packer/start/YouCompleteMe/install.py --verbose
```
