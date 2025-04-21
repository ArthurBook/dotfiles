# ------------------------------ main ------------------------------ 
function forward_port -d 'Forward a local port to a remote host via SSH gateway using autossh'
    # A utility for quickly setting up local port forwarding to a remote remote machine
    # through an SSH gateway, using `autossh`.
    #
    # Usage:
    #   forward_port [--verbose] <gateway> <remote-host> <remote-port> [local-port]
    #
    # Arguments:
    #   gateway      The SSH entry point (e.g. headnode, login-node)
    #   remote-host  Hostname of the machine within the remote (resolved via SSH)
    #   remote-port  Port on the remote host to forward (e.g. 8888 for Jupyter)
    #   local-port   (Optional) Local port to bind to. Defaults to same as remote-port.
    #
    # Flags:
    #   --verbose, -v   Print the full autossh command before executing it
    #
    # Examples:
    #   forward_port headnode gpu1 8888
    #     → Forwards localhost:8888 to gpu1:8888 via headnode
    #
    #   forward_port -v login-node compute5 6006 16006
    #     → Prints the autossh command, then forwards localhost:16006 to compute5:6006
    #
    # Tab completion:
    #   - gateway (1st arg): completes from your SSH known_hosts
    #   - remote host (2nd arg): dynamically fetched from the gateway using SSH + compgen
    #   - remote port (3rd arg): suggests common ports like 8888 (Jupyter), 6006 (TensorBoard), etc.
    #   - local port (4th arg): optional; defaults to same as remote port
    #
    # Requires:
    #   - SSH key access to the gateway
    #   - `autossh` installed
    #
    # Pro tip:
    #   Create aliases for common workflows:
    #     alias jupyter='forward_port headnode gpu-node 8888'

    set -l verbose 0
    set -l args
    for arg in $argv
        switch $arg
            case --verbose -v
                set verbose 1
            case '*'
                set args $args $arg
        end
    end
    set -l remote $args[1]
    set -l host $args[2]
    set -l rport $args[3]
    set -l lport $args[4]

    if test -z "$remote" -o -z "$host" -o -z "$rport"
        echo "Usage: forward_port [--verbose] <gateway> <remote-host> <remote-port> [local-port]"
        return 1
    end

    if test -z "$lport"
        set lport $rport
    end

    set -l cmd autossh -M 0 -N -L $lport:$host:$rport $remote

    if test $verbose -eq 1
        echo "🔍 Running: $cmd"
    else
        echo "🔌 Forwarding local port $lport to $host:$rport via $remote..."
    end

    eval $cmd
end

# ------------------------------ completion ------------------------------ 
# Description for the command itself
complete -c forward_port -d 'Set up local port forwarding to a host inside a remote via SSH gateway'
complete -c forward_port -f # disable file completion

# Argument 1: remote SSH gateway (e.g., headnode)
complete -c forward_port \
    -n 'test (count (commandline -opc)) -eq 1' \
    -a '(__fish_print_hostnames)' \
    -d 'remote gateway (SSH entry point)'

# Argument 2: host inside the remote (SSH hostname on the remote)
complete -c forward_port \
    -n 'test (count (commandline -opc)) -eq 2' \
    -a '(__list_remote_hosts)' \
    -d 'remote host (within the remote)'

# Argument 3: remote port to forward
complete -c forward_port \
    -n 'test (count (commandline -opc)) -eq 3' \
    -a '22 3000 5173 8080 8000 4200 5000 5174 8787 8888 8890 6006 8786 5432 3306 6379 27017 5900 3389' \
    -d 'remote port to forward (e.g. 8888 for Jupyter)'

# Argument 4: local port (optional)
complete -c forward_port \
    -n 'test (count (commandline -opc)) -eq 4' \
    -d 'local port (defaults to same as remote port)'

# Optional flag: --verbose
complete -c forward_port \
    -l verbose -s v \
    -d 'Print full autossh command before running'

function __list_remote_hosts
    # Used in completions to get available hostnames from the remote gateway
    set -l remote (commandline -opc | sed -n '2p')
    ssh $remote 'bash -c "compgen -A hostname"' 2>/dev/null
end
