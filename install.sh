#!/bin/bash

# global variables
INSTALL_PATH=~/.tool.d/regmonkey_gitcommand
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# main workflows
if [ -d $INSTALL_PATH ]; then
    echo "$INSTALL_PATH already exists."
else
    echo "$INSTALL_PATH does not exist. Creating now..."
    mkdir -p $INSTALL_PATH
fi

rsync -a --delete $SCRIPT_DIR/src/regmonkey_gitcommand/ $INSTALL_PATH
chmod +x $INSTALL_PATH/*

echo "The directory of the install.sh script is: $SCRIPT_DIR"
