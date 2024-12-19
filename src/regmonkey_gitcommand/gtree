#!/bin/bash
## Tree-display git-tracked files
## Author: Ryo Nakagami
## Revised: 2024-12-19
## REQUIREMENT: tree command

function usage {
    cat <<EOM
NAME
    $(basename "$0") - Lists the contents of a given tree object, like what "/bin/tree" does in the current git working directory.

Syntax
    $(basename "$0") <folder path>

DESCRIPTION
    This is a wrapper function of tree. 
    You need to install tree command in advance.
    
    When your current directory is a git-tracked folder, this allows you to show files that are not ignored in .gitignore.
    When you specify a directory which is not tracked by git as an input, gtree returns 
        <folder name>
        
        0 directories, 0 files

    When your current directory is not a git-tracked one, this returns the following error:
        <folder name>

        0 directories, 0 files
        fatal: not a git repository (or any of the parent directories): .git
    
OPTIONS
  -h, --help
    Display help

EOM

    exit 0
}

function error_message {
    echo 'fatal: something wrong! Check the input. Possibly your input is not a direcotry'
    exit 1
}

function directory_error_message {
    echo 'fatal: $1 does not exist. Check the folder input'
    exit 1
}

function not_git_repository_error {
    echo "fatal: not a git repository (or any of the parent directories): .git"
    exit 1
}


if [[ $1 == '-h' || $1 == '--help' ]]; then
    usage
    exit 1
fi 

if [[ $# == 0 ]]; then
    # git-managed chaeck
    if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
      not_git_repository_error
    fi

    git ls-tree -r --name-only HEAD | tree --fromfile
    exit 0

elif [[ $# == 1 ]]; then
    if [ -d $1 ]; then
        # git-managed chaeck
        if ! git -C "$1" rev-parse --is-inside-work-tree > /dev/null 2>&1; then
            not_git_repository_error
        fi
        git ls-tree -r --name-only HEAD $1 | tree --fromfile
    else
        directory_error_message
    fi
else
    error_message
fi
