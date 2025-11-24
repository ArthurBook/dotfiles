{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    claude-code # Agentic coding tool that lives in your terminal
    lazygit # A simple terminal UI for git commands
    ripgrep # Recursively searches directories
    fd # The friendly file finder
    pyright # Python LSP
    eza # Modern replacement for ls with colors and git integration
  ];
}
