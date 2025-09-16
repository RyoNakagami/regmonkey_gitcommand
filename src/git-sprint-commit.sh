#!/bin/bash

# git-sprint-commit - Create git commits with sprint week number
#
# Usage:
#   git sprint-commit               Create commit with sprint week format
#   git sprint-commit -m <message>  Create commit with sprint week prefix and message
#
# Options:
#   -m, --message <msg>   Commit message to append after sprint week prefix
#   -h, --help            Show this help
#
# Examples:
#   git sprint-commit          -> creates commit: sprint-2024-08w
#   git sprint-commit -m "Fix" -> creates commit: sprint-2024-08w: Fix

set -euo pipefail

print_help() {
    grep '^#\s' "$0" | sed 's/^# \{0,1\}//'
}

## Parse command line options
TEMP=$(getopt -o m:h --long message:,help -n 'git-sprint-commit' -- "$@") || {
    echo "Error: Invalid option" >&2
    exit 1
}
eval set -- "$TEMP"

message=""
while true; do
    case "$1" in
        -m|--message) message="$2"; shift 2 ;;
        -h|--help)    print_help; exit 0 ;;
        --) shift; break ;;
        *) echo "Internal error!" >&2; exit 1 ;;
    esac
done

## Get sprint week format (ISO week number)
sprint_week="sprint-$(date +%Y-%Vw)"

## If no message, commit only sprint week
if [ -z "$message" ] && [ $# -eq 0 ]; then
    if git diff --cached --quiet; then
        echo "No staged changes to commit." >&2
        exit 1
    fi
    git commit -m "$sprint_week"
    exit 0
fi

## Append leftover args to message
if [ $# -gt 0 ]; then
    if [ -n "$message" ]; then
        message="$message $*"
    else
        message="$*"
    fi
fi

## Commit with sprint prefix + message
if git diff --cached --quiet; then
    echo "No staged changes to commit." >&2
    exit 1
fi
git commit -m "$sprint_week: $message"
