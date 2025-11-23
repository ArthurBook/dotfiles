{ config, pkgs, ... }:

{
  imports = [
    ./shell/fish.nix
    ./shell/starship.nix
    ./shell/zellij.nix
    ./editor/neovim.nix
    ./packages.nix
    ./git.nix
  ];

  home.stateVersion = "24.05";
}

