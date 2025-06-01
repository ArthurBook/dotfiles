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
        local stdout=$(echo "$jobinfo" | grep -op 'stdout=\s+' | cut -d= -f2)
        local stderr=$(echo "$jobinfo" | grep -op 'stderr=\s+' | cut -d= -f2)
        tail-files "$stdout" "$stderr"
    fi
}

tail-files() {
    if [ "$#" -eq 0 ]; then
        echo "usage: tail-files file [file ...]"
        return 1
    fi

    local pids=()

    cleanup() {
        echo "cleaning up..."
        for pid in "${pids[@]}"; do
            kill "$pid" 2>/dev/null
        done
        wait
    }

    trap cleanup sigint sigterm exit

    for file in "$@"; do
        if [ -f "$file" ]; then
            tail -n 100 -f "$file" | sed "s|^|[$file] |" &
            pids+=($!)
        else
            echo "file not found: $file" >&2
        fi
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
    sacct -n -x -o jobid | tail -n "-$((index + 1))" | head -n 1
}
