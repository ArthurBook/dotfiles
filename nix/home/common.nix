{ config, pkgs, ... }:

{
  imports = [
    ./shell/fish.nix
    ./shell/starship.nix
  ];

  home.stateVersion = "24.05";
}

