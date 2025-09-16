#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: $0 -m <stash_message> -c <new_branch_name>"
    exit 1
}

# Parse command-line arguments
while getopts "m:c:" opt; do
    case "$opt" in
        m) stash_message="$OPTARG" ;;
        c) new_branch_name="$OPTARG" ;;
        *) usage ;;
    esac
done

# Check if the branch name is provided
if [ -z "$new_branch_name" ]; then
    usage
fi

# Use a default message if -m is empty
if [ -z "$stash_message" ]; then
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    commit_id=$(git rev-parse --short HEAD 2>/dev/null || echo "no-commit-id")
    stash_message="Stash created on $timestamp from commit $commit_id"
fi

# Command sequence
git stash push -a -m "$stash_message" &&
git switch -c "$new_branch_name" &&
git stash apply stash@{0}

echo "Successfully switched to branch '$new_branch_name' and applied stashed changes."
