{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ eza ];

  # Eza Tokyo Night theme
  home.file.".config/eza/theme.yml".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/eza-community/eza-themes/main/themes/tokyonight.yml";
    sha256 = "0mkiad3jhqy9rdm0sj9gwi46v4i38m9vg8021cwd1qx7003mijh6";
  };
}
