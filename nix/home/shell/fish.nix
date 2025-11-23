{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -gx PATH $HOME/.local/bin $PATH
    '';
    shellAliases = {
      ll = "ls -lh";
      la = "ls -lah";
    };
    functions = {
      fish_greeting = "";
    };
  };

}
