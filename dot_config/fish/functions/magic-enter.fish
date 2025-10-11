# Description: This plugin makes your enter key magical, by binding commonly used commands to it.
#
# Original source: https://github.com/mattmc3/magic-enter.fish/blob/main/conf.d/magic-enter.fish
# Adapted by: Arthur Book
# License: MIT

function magic-enter
    set -l cmd (commandline)
    if test -z "$cmd"
        commandline -r (magic-enter-cmd)
        commandline -f suppress-autosuggestion
    end
    commandline -f execute
end

function magic-enter-cmd --description "Print the command to run when no command was given"
    set -l cmd 'eza -l --hyperlink --header --git --git-repos --icons always -T -L 1'
    if command git rev-parse --is-inside-work-tree &>/dev/null
        set cmd git_summary
    end
    echo $cmd
end

function magic-enter-bindings --description "Bind magic-enter for default and vi key bindings"
    bind \r magic-enter
    if functions -q fish_vi_key_bindings
        bind -M insert \r magic-enter
        bind -M default \r magic-enter
    end
end
magic-enter-bindings
