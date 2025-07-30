#!/bin/bash
#--------------------------------------
# Description
#   The script iterates over each remote and pushes the specified branch to it 
#   using the git push command. The script retrieves the list of configured Git remotes 
#   using the git remote command and stores it in the variable REMOTES.
#   If no remotes are found, the script prints an error message and exits with a status code of 1.
#--------------------------------------


# Check if branch name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <branch-name>"
  exit 1
fi

# Define the branch name
BRANCH_NAME=$1

# Get the list of remotes
REMOTES=$(git remote)

# Check if there are any remotes configured
if [ -z "$REMOTES" ]; then
  echo "No remotes found. Please configure a remote repository."
  exit 1
fi

# Push to each remote
echo "$REMOTES" | while read -r REMOTE; do
    git push "$REMOTE" "$BRANCH_NAME"
done

exit 0
