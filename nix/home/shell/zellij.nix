{ config, pkgs, ... }:

{
  programs.zellij = {
    enable = true;
  };

  home.file.".config/zellij/config.kdl".text = ''
    // Minimal Zellij Configuration
    // Add your configuration here

  '';
}
