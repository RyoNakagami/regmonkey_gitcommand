#!/bin/bash
set -euo pipefail

usage() {
  echo "Usage: $0 -b <base-branch> -i <issue-number> -r <remote>"
  exit 1
}

# --- parse args ---
BASE=""
ISSUE=""
REMOTE="origin"
while getopts ":b:i:r:" opt; do
  case $opt in
    b) BASE="$OPTARG" ;;
    i) ISSUE="$OPTARG" ;;
    r) REMOTE="$OPTARG" ;;
    *) usage ;;
  esac
done

if [[ -z "$BASE" || -z "$ISSUE" ]]; then
  usage
fi

# --- get repo owner/name from git remote ---
REMOTE_URL=$(git remote get-url "$REMOTE")
if [[ "$REMOTE_URL" =~ github.com[:/](.+)/(.+)\.git ]]; then
  OWNER="${BASH_REMATCH[1]}"
  REPO="${BASH_REMATCH[2]}"
else
  echo "❌ Could not parse repo owner/name from remote: $REMOTE_URL"
  exit 1
fi

# --- get current branch ---
HEAD_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# --- confirmation prompt ---
echo "⚡ Ready to create a Pull Request:"
echo "  Repo:   $OWNER/$REPO"
echo "  Head:   $HEAD_BRANCH"
echo "  Base:   $BASE"
echo "  Issue:  #$ISSUE"
echo
read -rp "Do you want to continue? [y/N]: " CONFIRM

if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
  echo "❌ Aborted."
  exit 1
fi

# --- create PR ---
gh api "repos/$OWNER/$REPO/pulls" \
  -f "head=$HEAD_BRANCH" \
  -f "base=$BASE" \
  -F "issue=$ISSUE"
