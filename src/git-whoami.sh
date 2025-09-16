#!/bin/bash

# Get the Git user name and email from the configuration
user_name=$(git config user.name)
user_email=$(git config user.email)

# Check if the user name and email are set
if [ -z "$user_name" ] || [ -z "$user_email" ]; then
    echo "Git user name or email is not set."
    exit 1
fi

# Print the user name and email
echo "$user_name ($user_email)"
