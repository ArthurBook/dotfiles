{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -gx PATH $HOME/.local/bin $PATH
      starship init fish | source
      direnv hook fish | source
      set -U fish_key_bindings fish_vi_key_bindings

      if set -q ZELLIJ
      else
          zellij
      end
    '';
    shellAliases = {
      ls = "eza --color=always --group-directories-first";
      ll = "eza -l --color=always --group-directories-first";
      la = "eza -la --color=always --group-directories-first";
      lt = "eza -T --color=always --group-directories-first";
      nv = "nvim";
      cc = "claude";
    };
    functions = {
      fish_greeting = "";
    };
  };

}
