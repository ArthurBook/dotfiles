{ config, pkgs, ... }:

{
  imports = [
    ./shell/fish.nix
    ./shell/starship.nix
    ./shell/zellij.nix
    ./editor/neovim.nix
    ./editor/tools.nix
    ./packages.nix
    ./git.nix
  ];

  # Enable font installation
  fonts.fontconfig.enable = true;

  # Dust configuration file
  home.file.".config/dust/config.toml".text = ''
    # Tokyo Night themed dust configuration
    reverse = false
    bars_on_right = false
    no_colors = false
    force_colors = true
  '';

  home.stateVersion = "24.05";
}

