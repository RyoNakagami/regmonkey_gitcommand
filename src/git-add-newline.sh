#!/bin/bash
## Author: Ryo Nakagami
## Revised: 2025-07-29
## Description: Check for files missing a trailing newline in the git repository

set -euo pipefail

usage() {
    cat << EOF
Usage: git-newline-check [options]

Check for files missing a trailing newline in the current git repository.

Options:
    -h, --help     Show this help message
    -i PATTERN     Ignore files matching the given pattern (can be used multiple times)
EOF
    exit 0
}

# Initialize array for ignore patterns
declare -a ignore_patterns=()

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            ;;
        -i)
            if [[ -z ${2:-} ]]; then
                echo "Error: -i option requires a pattern argument"
                exit 1
            fi
            ignore_patterns+=("$2")
            shift 2
            ;;
        *)
            echo "Error: Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

# Ensure we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not a git repository"
    exit 1
fi

# Get all tracked files
while IFS= read -r -d '' file; do
    # Skip file if it matches any ignore pattern
    skip=0
    for pattern in "${ignore_patterns[@]}"; do
        if [[ $file =~ $pattern ]]; then
            skip=1
            break
        fi
    done
    [[ $skip -eq 1 ]] && continue

    # Skip binary files and SVG files (they don't require trailing newlines)
    if file --mime "${file}" | grep -q -e "charset=binary" -e "image/svg+xml"; then
        continue
    fi

    # Check if file ends with a newline
    if ! tail -c1 "${file}" | read -r _; then
        echo >> "${file}"; echo "✓ Newline added to: ${file}"
    fi
done < <(git ls-files -z)
