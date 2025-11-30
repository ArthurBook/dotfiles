{ config, pkgs, ... }:

let
  nixPackage = pkgs.nix;
in
{
  programs.fish = {
    enable = true;
    loginShellInit = ''
      # Initialize Nix (multi-user daemon) in fish
      if test -e "${nixPackage}/etc/profile.d/nix-daemon.fish"
        source "${nixPackage}/etc/profile.d/nix-daemon.fish"
      end
    '';
    interactiveShellInit = ''
      set -gx PATH $HOME/.local/bin $PATH
      starship init fish | source
      direnv hook fish | source
      set -U fish_key_bindings fish_vi_key_bindings

      # good old opt & cmd navigation
      bind -M insert ctrl-u backward-kill-line
      bind -M insert ctrl-a beginning-of-buffer
      bind -M insert ctrl-e end-of-buffer
      bind -M insert alt-b backward-word
      bind -M insert alt-f forward-word
      bind -M insert ctrl-w backward-kill-word # same as alt-backspace
      bind -M insert alt-backspace backward-kill-word

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
      da = "direnv allow";
    };
    functions = {
      fish_greeting = "";
    };
  };
}
