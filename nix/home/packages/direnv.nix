{ config, pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Global direnv helper functions
  home.file.".config/direnv/direnvrc".text = ''
    # Helper function for uv virtual environments
    source_python_venv() {
      local venv_dir="''${1:-.venv}"

      if [ ! -d "$venv_dir" ]; then
        log_status "$venv_dir not found — create one with 'uv venv' or 'uv sync'"
        return 1
      fi

      # direnv-native "activation": works for bash, zsh, fish
      source_env "$venv_dir/bin/activate"
    }
  '';
}
