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

  # Ghostty terminal configuration
  home.file.".config/ghostty/config".text = ''
    font-family = "Hack Nerd Font Mono"
    font-size = 10
    background-opacity = 0.90

    # Tokyo Night theme colors
    background = 1a1b26
    foreground = c0caf5
    cursor-color = c0caf5
    selection-background = 33467C
    selection-foreground = c0caf5

    # Normal colors
    palette = 0=#15161E
    palette = 1=#f7768e
    palette = 2=#9ece6a
    palette = 3=#e0af68
    palette = 4=#7aa2f7
    palette = 5=#bb9af7
    palette = 6=#7dcfff
    palette = 7=#a9b1d6

    # Bright colors
    palette = 8=#414868
    palette = 9=#f7768e
    palette = 10=#9ece6a
    palette = 11=#e0af68
    palette = 12=#7aa2f7
    palette = 13=#bb9af7
    palette = 14=#7dcfff
    palette = 15=#c0caf5
  '';
}
