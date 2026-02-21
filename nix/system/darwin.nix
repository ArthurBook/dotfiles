{ config, pkgs, lib, username, ... }:

{
  # Set the platform architecture
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Primary user for Homebrew and user-specific system configuration
  system.primaryUser = username;

  # System packages available to all users
  environment.systemPackages = with pkgs; [
    tailscale
    mosh
    mutagen
  ];

  # Enable tailscaled as a launchd daemon
  services.tailscale = {
    enable = true;
  };

  # Nix configuration
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "@admin" ];
  };

  # Nix daemon is managed automatically by nix-darwin

  # Create /etc/fishrc that loads the nix-darwin environment
  programs.fish.enable = true;

  # nix-homebrew configuration
  nix-homebrew = {
    enable = true;
    enableRosetta = true; # Apple Silicon Only
    user = username; # User owning the Homebrew prefix
  };

  # Homebrew configuration
  homebrew = {
    enable = true;

    # Clean up packages not listed in configuration
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };


    casks = [
      "antigravity"
      "cursor"
      "discord"
      "docker-desktop"
      "ghostty"
      "google-chrome"
      "google-drive"
      "granola"
      "nordvpn"
      "obsidian"
      "raycast"
      "rectangle"
      "slack"
      "whatsapp"
      "zoom"
    ];

    taps = [
    ];
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
