{ config, pkgs, ... }:

{
  imports = [
    ../home/common.nix
  ];

  home.username = "arthurbook";
  home.homeDirectory = "/Users/arthurbook";

  home.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
  };
}

