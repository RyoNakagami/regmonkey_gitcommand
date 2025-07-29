#!/bin/bash

check_tree_command() {
    if command -v tree &>/dev/null; then
        echo "tree is already installed."
    else
        if [[ "$OSTYPE" == "darwin"* ]]; then
            echo "Detected macOS. Installing tree using Homebrew..."
            brew install tree
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            echo "Detected Linux. Installing tree using APT..."
            sudo apt update
            sudo apt install -y tree
        else
            echo "Unsupported OS. Please install tree manually."
        fi
    fi
}

check_tree_command
