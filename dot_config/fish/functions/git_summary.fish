function git_summary
    if not test -d .git
        set_color --bold f7768e # Tokyo red
        echo "❌ Not a Git repository."
        set_color normal
        return 1
    end

    # Define section styles
    set -l color_section (set_color --bold 7aa2f7) # blue
    set -l color_reset (set_color normal)

    set -l git_status (git status --short --untracked-files --renames)
    if test -z "$git_status"
        set_color --bold a6e3a1 # green
        echo "✅ Working tree clean. No changes to show."
        set_color normal
    else
        echo "$color_section✏️ Files:$color_reset"
        echo "$git_status"
    end

    set -l stash_count (git stash list | wc -l | string trim)
    if test "$stash_count" -gt 0
        echo "$color_section📦 Stashes:$color_reset"
        git stash list | while read -l line
            set_color --bold cba6f7 # purple
            echo "• $line"
            set_color normal
        end
    end

    echo "$color_section🕘 Log:$color_reset"
    git-graph --max-count 10 --wrap auto --no-pager --style round
end
