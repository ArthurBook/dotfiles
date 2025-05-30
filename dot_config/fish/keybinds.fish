abbr nv nvim
abbr gp git push origin
abbr ls eza -l --hyperlink --header --git --git-repos --icons always -T -L 1

# good old opt & cmd navigation
bind -M insert ctrl-u backward-kill-line
bind -M insert ctrl-a beginning-of-buffer
bind -M insert ctrl-e end-of-buffer
bind -M insert alt-b backward-word
bind -M insert alt-f forward-word
bind -M insert ctrl-w backward-kill-word # same as alt-backspace
bind -M insert alt-backspace backward-kill-word