########################################################
# tail-slurm
#
# tail-slurm is a function that tails the stdout and stderr of a slurm job.
#
# usage: tail-slurm [--latest] [--jobid <jobid>]
#
# options:
#   --latest: tail the latest job
#   --jobid: tail the job with the given jobid
#
# examples:
#   tail-slurm --latest
#   tail-slurm --jobid 1234567890
########################################################

tail-slurm() {
    local jobid=$(_parse_args_to_slurm_job_id "$@")
    if [[ -z "$jobid" ]]; then
        echo "no job id provided use --latest or --jobid"
        return 1
    fi
    echo "job id: $jobid"
    local jobinfo=$(scontrol show job "$jobid")
    if [[ -z "$jobinfo" ]]; then
        echo "jobinfo not found"
        echo "job id: $(sacct -j "$jobid" -x)"
        return 1
    else
        local stdout=$(echo "$jobinfo" | grep -oP 'StdOut=\K\S+')
        local stderr=$(echo "$jobinfo" | grep -oP 'StdErr=\K\S+')
        tail-files "$stdout" "$stderr"
    fi
}

tail-files() {
    [ "$#" -eq 0 ] && { echo "usage: tail-files file [file ...]"; return 1; }
    local pids=()
    trap 'kill "${pids[@]}" 2>/dev/null' EXIT
    
    for file in "$@"; do
        [ -f "$file" ] || { echo "file not found: $file" >&2; continue; }
        tail -n 100 -f "$file" | perl -pe '
            s/\r.*?(?=\n|$)//g;  # Remove CR and everything after it
            s/\x1b\[[0-9;]*[mGKH]//g;  # Remove ANSI escape codes
            next if /^\s*$/;  # Skip empty lines
            s/^/['"$file"'] /;
        ' &
        pids+=($!)
    done
    wait
}

_parse_args_to_slurm_job_id() {
    local jobid=""
    local latest=$(_parse_latest_flag "$@")
    if [[ -n "$latest" ]]; then
        jobid=$(_get_latest_slurm_job "$latest")
    else
        jobid=$(_parse_jobid_flag "$@")
    fi
    [[ -n "$jobid" ]] && echo "$jobid" | tr -d '[:space:]'
}

_parse_jobid_flag() {
    local jobid=""
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --jobid)
                jobid="$2"
                shift 2
                ;;
            *)
                return 1
                ;;
        esac
    done
    [[ -n "$jobid" ]] && echo "$jobid"
}

_parse_latest_flag() { # gets the --latest flag and returns the index if it exists
    local latest=""
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --latest)
                if [[ -n "$2" && "$2" != --* ]]; then
                    latest="$2"
                    shift 2
                else
                    latest=0 # default to the latest job
                    shift 1
                fi
                ;;
            *)
                return 1
                ;;
        esac
    done
    [[ -n "$latest" ]] && echo "$latest"
}


_get_latest_slurm_job() {
    local index="${1:-0}"
    sacct --format=JobID -n -X | tail -n "-$((index + 1))" | head -n 1
}