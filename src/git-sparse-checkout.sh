#!/bin/bash
set -euo pipefail

usage() {
  echo "Usage: $0 -u <clone_url> -d <target_dir> -b <branch> -p <sparse_path> -s"
  exit 1
}

BARE=false

while getopts "su:d:b:p:" opt; do
  case $opt in
    s) BARE=true ;; 
    u) CLONE_URL=$OPTARG ;;
    d) TARGET_DIR=$OPTARG ;;
    b) BRANCH=$OPTARG ;;
    p) SPARSE_PATH=$OPTARG ;;
    *) usage ;;
  esac
done

if [[ -z "${CLONE_URL-}" || -z "${TARGET_DIR-}" || -z "${BRANCH-}" ]]; then
  usage
fi

if [[ "$BARE" = false && -z "${SPARSE_PATH-}" ]]; then
  echo "Error: -p <sparse_path> is required unless -s (bare mode) is specified."
  usage
fi

git clone --filter=blob:none --no-checkout "$CLONE_URL" "$TARGET_DIR"
cd "$TARGET_DIR"
git config core.sparseCheckout true

if $BARE; then
  {
    echo "/*"
    echo "!/*/"
  } > .git/info/sparse-checkout
  git checkout "$BRANCH"
  git ls-tree -r -d --name-only HEAD | xargs -I{} mkdir -p "{}"
  exit 0
fi

echo -e "$SPARSE_PATH" | tr ':' '\n' > .git/info/sparse-checkout
git checkout "$BRANCH"
