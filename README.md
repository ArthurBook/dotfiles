## Setup
load plug-vim:
```bash
brew install neovim
brew install cmake

pip install black flake8 pylint mypy

mkdir -p ~/.config/nvim

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

```bash
~/.config/nvim/plugged/YouCompleteMe/install.py --verbose
```
