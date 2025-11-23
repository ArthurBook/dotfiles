{ config, pkgs, ... }:

{
  imports = [
    ./shell/fish.nix
    ./shell/starship.nix
    ./shell/zellij.nix
  ];

  home.stateVersion = "24.05";
}

