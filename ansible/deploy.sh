#!/bin/bash

# deploy and uninstall standalone EMQX to target host

default_host="192.168.42.210"

usage() {
    cat <<EOF
Usage: $0 [OPTIONS] COMMAND

Deploy and uninstall standalone EMQX to target host.

Commands:
  install      Deploy EMQX to the target host
  uninstall    Uninstall EMQX from the target host

Options:
  -h, --help      Show this help message and exit
  -H, --host      Specify target host (default: $default_host)
  -e, --env       Specify target environment (int|stg, default: int)

Examples:
  $0 install
  $0 uninstall
  $0 -H ${default_host} -e int install
  $0 -H ${default_host} uninstall
  $0 -H 10.17.196.182 -e stg install
  $0 -H 10.17.196.182 uninstall
EOF
}

# Default values
target_host=${default_host}
target_env="int"
action=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            exit 0
            ;;
        -H|--host)
            target_host="$2"
            shift 2
            ;;
        -e|--env)
            target_env="$2"
            shift 2
            ;;
        install|uninstall)
            action="$1"
            shift
            ;;
        *)
            echo "Error: Unknown argument: $1"
            usage
            exit 1
            ;;
    esac
done

# Validate action
if [ -z "$action" ]; then
    echo "Error: No command specified"
    usage
    exit 1
fi

# Validate environment
if [ "$action" == "install" ]; then
    if [ "$target_env" != "int" ] && [ "$target_env" != "stg" ]; then
        echo "Error: Invalid environment '$target_env'. Only 'int' and 'stg' are supported."
        usage
        exit 1
    fi
fi

# Execute the action
if [ "$action" == "install" ]; then
    echo "Deploying EMQX to $target_host with environment: $target_env"
    ansible-playbook -i "$target_host", install.yml -e "target_host=$target_host"
elif [ "$action" == "uninstall" ]; then
    echo "Uninstalling EMQX from $target_host"
    ansible-playbook -i "$target_host", uninstall.yml -e "target_host=$target_host"
else
    echo "Error: Invalid command: $action"
    usage
    exit 1
fi
