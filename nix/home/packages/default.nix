{ config, pkgs, ... }:

{
  imports = [
    ./bat.nix
    ./bottom.nix
    ./direnv.nix
    ./eza.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Packages without configuration - simple installations
  home.packages = with pkgs; [
    # Modern CLI tools
    cloc # Count lines of code
    dust # Modern replacement for du with better visualization
    fd # The friendly file finder
    procs # Modern ps replacement
    ripgrep # Recursively searches directories
    uv # Fast Python package and project manager

    # Secret management
    sops # Secret operations tool for encrypting files
    age # Modern encryption tool for SOPS
    ssh-to-age # Convert SSH keys to age keys
    pre-commit # Git hooks management

    # Fonts
    nerd-fonts.hack
  ];
}
