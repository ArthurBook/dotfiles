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

    echo "$color_section✏️ Files:$color_reset"
    git status --short --untracked-files --renames
    echo
    echo "$color_section🕘 Log:$color_reset"
    git-graph --max-count 10 --wrap auto --no-pager --style round
end
