# My setup

## Deps

### ubuntu
```bash
apt install zsh # https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#ubuntu-debian--derivatives-windows-10-wsl--native-linux-kernel-with-windows-10-build-1903
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # https://ohmyz.sh/#install
curl https://pyenv.run | bash # https://github.com/pyenv/pyenv?tab=readme-ov-file#automatic-installer
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh # https://www.rust-lang.org/tools/install
```
### macos
```bash
brew install zsh # https://formulae.brew.sh/formula/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # https://ohmyz.sh/#install
brew install pyenv # https://github.com/pyenv/pyenv?tab=readme-ov-file#installation
brew install rustup # https://formulae.brew.sh/formula/rustup
```

## Apply dotfiles
```bash
# install to ~/projects/dotfiles/
mkdir -p ~/projects
git clone git@github.com:ArthurBook/dotfiles.git ~/projects/dotfiles
~/projects/dotfiles/install
```
