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

check_yamlcli_command() {
    if command -v yamlcli &>/dev/null; then
        echo "yamlcli is already installed."
    else
        if [[ "$OSTYPE" == "darwin"* ]]; then
            uv tool install git+https://github.com/RyoNakagami/yamlcli.git
              
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            echo "Detected Linux. Installing yamlcli using npm..."
            if command -v npm &>/dev/null; then
                uv tool install git+https://github.com/RyoNakagami/yamlcli.git
            else
                echo "npm is not installed. Please install npm first."
                return 1
            fi
        else
            echo "Unsupported OS. Please install yamlcli manually."
            return 1
        fi
    fi
}

# Run checks
check_tree_command
check_yamlcli_command
