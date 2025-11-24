<img align="right" width="250" src="static/dotfiles-logo-icon.png" alt="DOT DOT DOT">

# `My . . .` 

[![nix](https://img.shields.io/badge/NixOS-%235277C3.svg?style=flat-square&logo=nixos&logoColor=white)](https://nixos.org/)
![MacOS](https://img.shields.io/badge/macOS-%23.svg?style=flat-square&logo=apple&color=000000&logoColor=white)
![Linux](https://img.shields.io/badge/Linux%20-yellow.svg?style=flat-square&logo=linux&logoColor=black)
![Neovim](https://img.shields.io/badge/Neovim-%23057A3A.svg?style=flat-square&logo=neovim&logoColor=white)

Install [nix](https://nixos.org/download/):
```bash
bash <(curl -L https://nixos.org/nix/install) --daemon
echo 'experimental-features = nix-command flakes' | sudo tee -a /etc/nix/nix.conf
nix run home-manager/master -- switch --flake .#macos
```

