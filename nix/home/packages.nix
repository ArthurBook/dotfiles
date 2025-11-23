{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    lazygit # A simple terminal UI for git commands
    ripgrep # Recursively searches directories
    fd # The friendly file finder
    pyright # Python LSP
  ];
}
