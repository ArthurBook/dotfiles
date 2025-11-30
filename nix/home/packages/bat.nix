{ config, pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      theme = "tokyonight";
      style = "grid,header,numbers";
      pager = "less -RK";
      paging = "always";
    };
    themes = {
      tokyonight = {
        src = pkgs.fetchFromGitHub {
          owner = "folke";
          repo = "tokyonight.nvim";
          rev = "v4.8.0";
          sha256 = "sha256-5QeY3EevOQzz5PHDW2CUVJ7N42TRQdh7QOF9PH1YxkU=";
        };
        file = "extras/sublime/tokyonight_night.tmTheme";
      };
    };
  };
}
