{ config, pkgs, ... }:

{
  imports = [
    ./bat.nix
    ./bottom.nix
    ./direnv.nix
    ./eza.nix
    ./lazydocker.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Packages without configuration - simple installations
  home.packages = with pkgs; [
    # Modern CLI tools
    cloc # Count lines of code
    dust # Modern replacement for du with better visualization
    fd # The friendly file finder
    procs # Modern ps replacement
    rclone # Command line program for cloud storage
    ripgrep # Recursively searches directories
    s5cmd # Fast S3/cloud storage command line tool
    uv # Fast Python package and project manager

    # Network monitoring tools
    bandwhich # Per-process network usage monitor
    bmon # Network bandwidth monitor

    # Secret management
    sops # Secret operations tool for encrypting files
    age # Modern encryption tool for SOPS
    ssh-to-age # Convert SSH keys to age keys
    pre-commit # Git hooks management

    # Fonts
    nerd-fonts.hack
  ];
}
