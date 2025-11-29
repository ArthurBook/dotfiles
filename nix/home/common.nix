{ config, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./packages.nix
    ./secrets.nix
    ./editor/neovim.nix
    ./editor/tools.nix
    ./shell/fish.nix
    ./shell/starship.nix
    ./shell/zellij.nix
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

  home.stateVersion = "25.05";
}
