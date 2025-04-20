# Completions (keep as is)
complete -c git-pretty-status -l no-staged -d "Hide staged changes section"
complete -c git-pretty-status -l no-unstaged -d "Hide unstaged & untracked changes"
complete -c git-pretty-status -l no-stash -d "Hide stash list"
complete -c git-pretty-status -l no-log -d "Hide recent commit log"

function git-pretty-status
    # --- Tokyonight Color Palette (Adjust hex/RGB as needed) ---
    set -l color_reset (printf '\033[0m')
    set -l color_bold (printf '\033[1m')
    set -l color_dim (printf '\033[2m')

    # Colors based on eza-tokyonight theme (using 24-bit true color codes)
    set -l tn_green (printf '\033[38;2;158;206;106m') # #9ece6a (staged, new, success)
    set -l tn_red (printf '\033[38;2;219;75;75m') # #db4b4b (deleted, error)
    set -l tn_orange (printf '\033[38;2;255;158;100m') # #ff9e64 (modified unstaged?)
    set -l tn_cyan (printf '\033[38;2;42;195;222m') # #2ac3de (untracked, info, author)
    set -l tn_yellow (printf '\033[38;2;224;175;104m') # #e0af68 (commit hash, date)
    set -l tn_purple (printf '\033[38;2;187;154;247m') # #bb9af7 (modified unstaged?)
    set -l tn_light_gray (printf '\033[38;2;169;177;214m') # #a9b1d6 (headers, summary)
    set -l tn_dark_gray (printf '\033[38;2;115;122;162m') # #737aa2 (dim info, time)
    set -l tn_blue (printf '\033[38;2;122;162;247m') # #7aa2f7 (stash list?)

    # --- Semantic Color Assignments ---
    set -l color_header "$color_bold$tn_light_gray"
    set -l color_staged "$tn_green"
    set -l color_unstaged "$tn_red"
    set -l color_untracked "$tn_purple"
    set -l color_stash "$tn_blue"
    set -l color_log_hash "$tn_yellow"
    set -l color_log_author "$tn_cyan"
    set -l color_log_time "$tn_dark_gray$color_dim"
    set -l color_error "$tn_red"
    set -l color_success "$tn_green"
    set -l color_summary "$tn_light_gray"

    # --- Function Logic ---
    if not test -d .git
        echo "$color_error❌ Not a Git repository.$color_reset"
        return 1
    end

    set -l show_staged 1
    set -l show_unstaged 1
    set -l show_stash 1
    set -l show_log 1

    # Parse flags
    for arg in $argv
        switch $arg
            case --no-staged
                set show_staged 0
            case --no-unstaged
                set show_unstaged 0
            case --no-stash
                set show_stash 0
            case --no-log
                set show_log 0
        end
    end

    echo # Initial newline

    # --- Staged Changes ---
    if test $show_staged -eq 1
        set -l staged_lines (git diff --cached --stat | wc -l)
        if test $staged_lines -eq 0
            echo "$color_success☑️ No staged changes$color_reset"
        else
            echo "$color_header✅ Staged Changes:$color_reset"

            set -l staged_stat (git diff --cached --stat)
            set -l staged_summary ""
            set -l staged_entries

            for line in $staged_stat
                if not string match -q -- "*|*" $line
                    set staged_summary $line # Keep the last non-entry line as summary
                else
                    set -a staged_entries $line
                end
            end

            if test -n "$staged_summary"
                echo "  $color_summary$staged_summary$color_reset"
            end
            for line in $staged_entries
                set -l parts (string split -m1 "|" $line)
                set -l filepath (string trim $parts[1])
                set -l rest $parts[2]
                printf "  %s%s%s |%s\n" $color_staged $filepath $color_reset $rest
            end
        end
        echo # Newline after section
    end

    # --- Unstaged Changes ---
    if test $show_unstaged -eq 1
        set -l unstaged_lines (git diff --stat | wc -l)
        set -l untracked_files (git ls-files --others --exclude-standard)

        if test $unstaged_lines -eq 0 -a (count $untracked_files) -eq 0
            echo "$color_success🟢 No unstaged changes or untracked files$color_reset"
        else
            echo "$color_header✏️ Unstaged Changes & Untracked Files:$color_reset"

            set -l unstaged_stat (git diff --stat)
            set -l unstaged_summary ""
            set -l unstaged_entries

            for line in $unstaged_stat
                if not string match -q -- "*|*" $line
                    set unstaged_summary $line # Keep the last non-entry line as summary
                else
                    set -a unstaged_entries $line
                end
            end

            if test -n "$unstaged_summary"
                echo "  $color_summary$unstaged_summary$color_reset"
            end
            for line in $unstaged_entries
                set -l parts (string split -m1 "|" $line)
                set -l filepath (string trim $parts[1])
                set -l rest $parts[2]
                # Using purple for modified/deleted unstaged
                printf "  %s%s%s |%s\n" $color_unstaged $filepath $color_reset $rest
            end

            for file in $untracked_files
                # Using cyan for untracked
                printf "  %s%s%s | untracked\n" $color_untracked $file $color_reset
            end
        end
        echo # Newline after section
    end

    # --- Stash List ---
    if test $show_stash -eq 1
        set -l stash_list (git stash list)
        if test (count $stash_list) -gt 0
            echo "$color_header📥 Stashes:$color_reset"
            for line in $stash_list
                # Using blue for stash entries
                echo "  $color_stash$line$color_reset"
            end
            echo # Newline after section
        end
    end

    # --- Recent Commits ---
    if test $show_log -eq 1
        echo "$color_header🕘 Recent Commits:$color_reset"
        # Removed %C(auto) - applying colors manually below
        git log --graph --oneline --decorate=short --date=relative --pretty=format:'%h%d%x09%an%x09%ar%x09%s' -n 6 | while read -l line
            set -l graph_prefix (string match -r '^[*|\\/ ]+' -- $line)
            set -l rest (string replace -- "$graph_prefix" "" $line)

            # Split carefully by tab, handling potential missing fields if needed
            set -l parts (string split \t -- $rest)
            set -l hash_deco (echo $parts[1] | string trim) # Hash and decorations (branch names, tags)
            set -l author (echo $parts[2] | string trim)
            set -l rel_time (echo $parts[3] | string trim)
            set -l message (string join \t $parts[4..-1]) # Join remaining parts for message

            # Apply colors: Graph | Hash/Deco | Author | Time | Message
            printf "  %s%s%s%s  %s%s%s  %s%s%s  %s\n" \
                $graph_prefix \
                $color_log_hash $hash_deco $color_reset \
                $color_log_author $author $color_reset \
                $color_log_time $rel_time $color_reset \
                $message # Message retains its original format/color potentially set by git internally if any remains
        end
        echo # Newline after section
    end
end
