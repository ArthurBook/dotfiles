{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    bottom # Modern htop replacement
    cloc # Count lines of code
    direnv # Automatically load environment variables
    dust # Modern replacement for du with better visualization
    eza # Modern replacement for ls with colors and git integration
    fd # The friendly file finder
    procs # Modern ps replacement
    ripgrep # Recursively searches directories
    
    # Nerd Fonts
    nerd-fonts.hack
  ];

  programs.bat = {
    enable = true;
    config = {
      theme = "tokyonight";
      style = "numbers,changes,header";
      pager = "less -FR";
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

  # Eza Tokyo Night theme
  home.file.".config/eza/theme.yml".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/eza-community/eza-themes/main/themes/tokyonight.yml";
    sha256 = "0mkiad3jhqy9rdm0sj9gwi46v4i38m9vg8021cwd1qx7003mijh6";
  };


  # Bottom (btm) configuration with Tokyo Night theme
  home.file.".config/bottom/bottom.toml".text = ''
    # Tokyo Night color scheme
    [colors]
    table_header_color = "LightBlue"
    all_entry_color = "White"
    avg_entry_color = "Red"
    cpu_core_colors = ["LightMagenta", "LightYellow", "LightCyan", "LightGreen", "LightBlue", "LightRed", "Cyan", "Green", "Blue", "Red"]
    ram_color = "LightMagenta"
    cache_color = "LightYellow"
    swap_color = "LightRed"
    arc_color = "LightCyan"
    gpu_core_colors = ["LightBlue", "LightRed", "Cyan", "Green", "Blue", "Red"]
    rx_color = "LightCyan"
    tx_color = "LightYellow"
    widget_title_color = "Gray"
    border_color = "Gray"
    highlighted_border_color = "LightBlue"
    text_color = "Gray"
    graph_color = "Gray"
    cursor_color = "Red"
    selected_text_color = "Black"
    selected_bg_color = "LightBlue"
    high_battery_color = "green"
    medium_battery_color = "yellow"
    low_battery_color = "red"

    [flags]
    hide_avg_cpu = false
    dot_marker = false
    temperature_type = "celsius"
    rate = 1000
    left_legend = false
    current_usage = false
    group_processes = true
    case_sensitive = false
    whole_word = false
    regex = false
    basic = false
    use_old_network_legend = false
    battery = false
  '';
}
