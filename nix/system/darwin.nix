{ config, pkgs, ... }:

{
  # Set the platform architecture
  nixpkgs.hostPlatform = "aarch64-darwin";

  # System packages available to all users
  environment.systemPackages = with pkgs; [
    tailscale
    mosh
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

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
