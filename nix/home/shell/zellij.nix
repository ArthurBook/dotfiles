{ config, pkgs, ... }:

{
  programs.zellij = {
    enable = true;
  };

  home.file.".config/zellij/config.kdl".text = ''
    default_shell "fish"
    theme "tokyo-night"
    copy_on_select true
    show_startup_tips false

    ui {
      pane_frames {
        rounded_corners true
      }
    }

    keybinds {
      unbind "Alt f" // conflicts with the text jumps
      normal {
        bind "Super f" { ToggleFloatingPanes; } // remap
        bind "Super k" { Clear; }
      }
    }
  '';
}
