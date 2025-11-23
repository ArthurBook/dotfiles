{ config, pkgs, ... }:

{
  imports = [
    ./shell/fish.nix
  ];

  home.stateVersion = "24.05";
}

