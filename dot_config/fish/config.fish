if status is-interactive
    # set config root path
    set -l config_root ~/.config/fish

    # eagerly load function descriptions
    for f in $config_root/functions/*.fish
        functions --query (basename $f .fish); or functions (basename $f .fish) >/dev/null
    end

    # keybinds
    source $config_root/keybinds.fish

    # paths
    source $config_root/paths.fish

    # tmux
    set fish_tmux_autostart true

    # prompt
    starship init fish | source
end
