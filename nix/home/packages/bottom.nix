{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ bottom ];

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
    regex = true
    basic = false
    use_old_network_legend = false
    battery = false
  '';
}
