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

  home.file.".config/zellij/layouts/network-monitor.kdl".text = ''
    layout {
      tab name="network-monitor" focus=true {
        pane size=2 borderless=true {
          plugin location="tab-bar"
        }
        pane split_direction="horizontal" {
          pane command="bmon" start_suspended=false {
            args "-U" "-p" "en0"
          }
          pane command="sudo" start_suspended=false {
            args "bandwhich" "--show-dns" "--no-resolve" "--unit-family" "si-bits"
          }
        }
        pane size=1 borderless=true {
          plugin location="status-bar"
        }
      }
    }
  '';
}
