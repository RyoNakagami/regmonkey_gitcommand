#!/bin/bash
set -euo pipefail

# Defaults
hostname="github.com"
target_dir=""

usage() {
    echo "Usage: $0 [-h hostname] [-d directory] <https_url>"
    echo "Example: $0 -h github-work -d mydir https://github.com/user/repo.git"
    exit 1
}

while getopts "h:d:" opt; do
    case $opt in
        h) hostname="$OPTARG" ;;
        d) target_dir="$OPTARG" ;;
        *) usage ;;
    esac
done
shift $((OPTIND - 1))

if [ $# -ne 1 ]; then
    usage
fi

https_url="$1"

# Extract path after 'https://<something>/'
repo_path=$(echo "$https_url" | sed -E 's#https://[^/]+/##')

# Construct SSH URL
ssh_url="git@${hostname}:${repo_path}"

echo "[INFO] Cloning: $ssh_url"

if [ -n "$target_dir" ]; then
    git clone "$ssh_url" "$target_dir"
else
    git clone "$ssh_url"
fi
