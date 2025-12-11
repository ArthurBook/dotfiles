<img align="right" width="250" src="static/dotfiles-logo-icon.png" alt="DOT DOT DOT">

# `My . . .`

[![nix](https://img.shields.io/badge/NixOS-%235277C3.svg?style=flat-square&logo=nixos&logoColor=white)](https://nixos.org/)
![MacOS](https://img.shields.io/badge/macOS-%23.svg?style=flat-square&logo=apple&color=000000&logoColor=white)
![Linux](https://img.shields.io/badge/Linux%20-yellow.svg?style=flat-square&logo=linux&logoColor=black)
![Neovim](https://img.shields.io/badge/Neovim-%23057A3A.svg?style=flat-square&logo=neovim&logoColor=white)

Install [nix](https://nixos.org/download/):
```bash
bash <(curl -L https://nixos.org/nix/install) --daemon # get nix
echo 'experimental-features = nix-command flakes' | sudo tee -a /etc/nix/nix.conf
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh # activate nix
```

Setup env:
```bash
DOTFILES_LOC=~/projects/dotfiles
git clone git@github.com:ArthurBook/dotfiles.git ${DOTFILES_LOC}
cd ${DOTFILES_LOC}

# Single command setup (includes both system and home configuration)
sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin/nix-darwin-25.05#darwin-rebuild -- switch --flake .
```

Setup home manager:
```bash
nix run github:nix-community/home-manager/release-25.05 -- switch --flake .#macos
```

After initial setup, use this single command to rebuild everything:
```bash
sudo nix run nix-darwin#darwin-rebuild -- switch --flake .
```

> **Note:** This configures both system-level (nix-darwin) and user-level (home-manager) settings in one command.
