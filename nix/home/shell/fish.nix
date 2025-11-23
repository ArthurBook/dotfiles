{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -gx PATH $HOME/.local/bin $PATH
      starship init fish | source
      set -U fish_key_bindings fish_vi_key_bindings

      if set -q ZELLIJ
      else
          zellij
      end
    '';
    shellAliases = {
      ll = "ls -lh";
      la = "ls -lah";
      nv = "nvim";
    };
    functions = {
      fish_greeting = "";
    };
  };

}
