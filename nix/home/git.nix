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
        # NOTE: not checked into git; contains secrets
        path = "~/.config/git/personal";
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
      alias = {
        undo = "reset --soft HEAD~1";
        reword = "commit --amend --only";
        amend = "commit --amend --no-edit";
      };
      color = {
        ui = "auto";
      };
      rerere = {
        enabled = true;
      };
    };
  };
}
