# Git Helper Scripts Documentation

A collection of git helper scripts to enhance your git workflow.

## Table of Contents

- [git-check-commitsize](#git-check-commitsize) - Analyze commit sizes in repository
- [git-lastdiff](#git-lastdiff) - Show diff between last commit and current state
- [git-newline-check](#git-newline-check) - Check for missing trailing newlines
- [git-tmp-checkout](#git-tmp-checkout) - Create temporary branch with stashed changes
- [git-tree](#git-tree) - Display git-tracked files in tree format
- [git-whoami](#git-whoami) - Display git user identity

## git-check-commitsize

Analyzes and reports commit sizes in a git repository, helping identify large commits.

### Usage
```bash
git-check-commitsize [options]
```

### Options
- `-u, --unit <unit>` - Unit of size (B, KB, MB, GB)
- `-l, --lowersize <size>` - Lower size threshold
- `-d, --days <days>` - Number of days to look back
- `-h, --help` - Show help message

### Example
```bash
# List commits larger than 3MB in the last 10 days
git-check-commitsize -unit MB -lowersize 3 -days 10
```

### Output Format
```
commit-size  commit-id   file-number  commit-date
```

## git-lastdiff

Shows differences between the last commit and current state of a specified file using git difftool.

### Usage
```bash
git-lastdiff <file_path>
```

### Features
- Automatically fetches the last commit ID for the specified file
- Uses git difftool for comparison
- Shows visual diff between last commit and current state

## git-newline-check

Checks for files missing trailing newlines in the git repository.

### Usage
```bash
git-newline-check [options]
```

### Options
- `-h, --help` - Show help message
- `-i PATTERN` - Ignore files matching the given pattern (can be used multiple times)

### Features
- Skips binary files and SVG files automatically
- Supports custom ignore patterns
- Reports files missing trailing newlines

## git-tmp-checkout

Creates a temporary branch with stashed changes, useful for experimental work.

### Usage
```bash
git-tmp-checkout -m <stash_message> -c <new_branch_name>
```

### Options
- `-m` - Stash message (optional, auto-generated if not provided)
- `-c` - New branch name (required)

### Features
- Automatically stashes current changes
- Creates new branch
- Applies stashed changes to new branch

## git-tree

Lists git-tracked files in a tree structure, similar to the `tree` command but only showing git-tracked files.

### Usage
```bash
git-tree [folder_path]
```

### Requirements
- `tree` command must be installed

### Features
- Shows only git-tracked files
- Supports specific directory viewing
- Maintains tree-like structure output

### Error Cases
- Not a git repository
- Invalid directory input
- Non-git-tracked directory

## git-whoami

Displays the configured git user name and email.

### Usage
```bash
git-whoami
```

### Output
```
username (email@example.com)
```

### Features
- Shows current git configuration identity
- Validates both name and email are set
