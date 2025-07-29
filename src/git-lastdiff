#!/bin/bash
## git difftool
## Author: Ryo Nakagami
## Revised: 2024-12-17
## REQUIREMENT

set -eu

# Function to display usage information
function usage {
    cat <<EOM
NAME
    $(basename "$0")
        This script uses git difftool to show the differences between the last commit and the 
        current state of the specified file.

Syntax
    $(basename "$0") <folder path>

EOM

    exit 1
}



# Function to check if a file exists
check_file_exists() {
  local file="$1"
  if [[ ! -f "$file" ]]; then
    echo "File '$file' does not exist."
    exit 1
  fi
}

# Function to fetch commit ID
fetch_commitid() {
  local file="$1"
  COMMIT_ID=$(git log --format="%H" -n 1 -- "$file")
  if [[ -z "$COMMIT_ID" ]]; then
    echo "Failed to fetch commit ID for '$file'."
    exit 1
  fi
  echo "$COMMIT_ID"
}

# arg check
if [[ $# -eq 0 ]]; then
  usage
fi

TARGET_FILE="$1"

if [[ -z "$TARGET_FILE" ]]; then
  echo "Error: TARGET_FILE is empty."
  exit 1
fi

check_file_exists "$TARGET_FILE"


# main
COMMIT_ID=$(fetch_commitid "$TARGET_FILE")
git difftool -y "$COMMIT_ID~1" HEAD -- "$TARGET_FILE"
