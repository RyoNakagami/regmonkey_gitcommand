#!/bin/bash
set -euo pipefail

BROWSER=""
REF=""

usage() {
    cat << EOF
Usage: git-browse [-b browser] [-r ref] [-h]

Open the remote repository URL in a browser.

Options:
  -b <browser>  Use specified browser (e.g., firefox, chrome)
  -r <ref>      Open specific branch/tag/commit URL
  -h           Show this help message

Examples:
  # Open default remote in default browser
  git browse

  # Open in Firefox
  git browse -b firefox

  # Open specific branch
  git browse -r main

  # Open specific commit
  git browse -r 1234abc
EOF
    exit 1
}

# Validate browser
validate_browser() {
    local browser=$1
    case "$browser" in
        firefox|chrome|chromium|google-chrome)
            return 0
            ;;
        *)
            echo "❌ Error: Unsupported browser: $browser" >&2
            echo "Supported browsers: firefox, chrome, chromium, google-chrome" >&2
            exit 1
            ;;
    esac
}

# Parse command-line arguments
while getopts "b:r:h" opt; do
    case "$opt" in
        b) 
            BROWSER="$OPTARG"
            validate_browser "$BROWSER"
            ;;
        r) REF="$OPTARG" ;;
        h) usage ;;
        *) usage ;;
    esac
done

# Get list of push remotes
remotes=($(git remote -v | awk '/\(push\)/ {print $2}' | sort -u))
if [ ${#remotes[@]} -eq 0 ]; then
    echo "❌ Error: No push remotes found" >&2
    exit 1
fi

# Handle multiple remotes with simple numbered menu
if [ ${#remotes[@]} -gt 1 ]; then
    echo "Multiple remotes found. Please select one:"
    select remote in "${remotes[@]}"; do
        if [ -n "$remote" ]; then
            break
        else
            echo "❌ Invalid selection. Please try again."
        fi
    done
else
    remote="${remotes[0]}"
fi

# Modify URL if ref is specified
if [ -n "$REF" ]; then
    # Handle different remote URL formats
    if [[ "$remote" =~ ^git@ ]]; then
        # SSH format
        remote=$(echo "$remote" | sed "s|:|/|" | sed "s|^git@|https://|")
    elif [[ "$remote" =~ ^https?:// ]]; then
        # Already HTTPS format, nothing to do
        :
    else
        echo "❌ Error: Unsupported remote URL format: $remote" >&2
        exit 1
    fi
    
    # Remove .git suffix if present
    remote=${remote%.git}
    
    # Handle different hosting services
    if [[ "$remote" =~ github.com ]]; then
        if git rev-parse --verify "$REF^{commit}" >/dev/null 2>&1; then
            remote="$remote/commit/$REF"
        else
            # Handle branch names with slashes
            branch_path=${REF//\//%2F}
            remote="$remote/tree/$branch_path"
        fi
    elif [[ "$remote" =~ gitlab.com ]]; then
        if git rev-parse --verify "$REF^{commit}" >/dev/null 2>&1; then
            remote="$remote/-/commit/$REF"
        else
            branch_path=${REF//\//%2F}
            remote="$remote/-/tree/$branch_path"
        fi
    elif [[ "$remote" =~ bitbucket.org ]]; then
        if git rev-parse --verify "$REF^{commit}" >/dev/null 2>&1; then
            remote="$remote/commits/$REF"
        else
            branch_path=${REF//\//%2F}
            remote="$remote/src/$branch_path"
        fi
    else
        # Default to GitHub-style URLs for unknown hosts
        if git rev-parse --verify "$REF^{commit}" >/dev/null 2>&1; then
            remote="$remote/commit/$REF"
        else
            branch_path=${REF//\//%2F}
            remote="$remote/tree/$branch_path"
        fi
    fi
fi

# Open in specified browser or default
if [ -n "$BROWSER" ]; then
    echo "Opening in $BROWSER: $remote"
    git web--browse -b $BROWSER "$remote" >/dev/null 2>&1
else
    echo "Opening in default browser: $remote"
    git web--browse "$remote" >/dev/null 2>&1
fi
