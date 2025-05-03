function git_summary
    if not command git rev-parse --is-inside-work-tree &>/dev/null
        set_color --bold f7768e
        echo "❌ Not a Git repository."
        set_color normal
        return 1
    end

    set -l git_status (git -c color.status=always --no-pager status --short --untracked-files --renames)
    if test -z "$git_status"
        set_color --bold a6e3a1
        echo "✅ Working tree clean. No changes to show."
        set_color normal
    else
        set_color --bold 7aa2f7
        echo "✏️ Files:"
        set_color normal
        for line in $git_status
            echo $line
        end
    end

    set -l stash_count (git stash list | wc -l | string trim)
    if test "$stash_count" -gt 0
        set_color --bold 7aa2f7
        echo "📦 Stashes:"
        git stash list | while read -l line
            set_color --bold cba6f7
            echo "• $line"
            set_color normal
        end
    end

    set_color --bold 7aa2f7
    echo "🕘 Log:"
    set_color normal
    git-graph --max-count 10 --wrap auto --no-pager --style round
end
