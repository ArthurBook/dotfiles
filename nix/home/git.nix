{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    ignores = [
      ".env*"
      ".envrc"
      ".DS_Store"
      ".vscode/.*"
      ".python.version"
    ];

    extraConfig = {
      include = {
        path = "~/.config/git/personal.gitconfig";
      };
      core = {
        editor = "nvim";
      };
      fetch = {
        prune = true;
      };
      push = {
        default = "current";
        autoSetupRemote = true;
      };
      pull = {
        rebase = true;
      };
      color = {
        ui = "auto";
      };
    };
  };
}
