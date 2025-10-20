# regmonkey_gitcommand

![Release](https://img.shields.io/github/tag/ryonakagami/regmonkey_gitcommand.svg)
![License](https://img.shields.io/github/license/ryonakagami/regmonkey_gitcommand.svg)
![Issues](https://img.shields.io/github/issues/ryonakagami/regmonkey_gitcommand.svg)

---

- This repository contains a collection of useful Git commands and scripts to help manage and automate your Git workflow.
- This repository is primarily intended for use on Linux or macOS systems.

## Dependency

|command|Ubuntu|MacOS|
|---|---|---|
|`tree`|`apt install tree`|`brew install tree`|
|`yamlcli`|`uv tool install git+https://github.com/RyoNakagami/yamlcli.git`|`uv tool install git+https://github.com/RyoNakagami/yamlcli.git`|

## Install

1. **Clone the repository**:

    ```bash
    git clone https://github.com/RyoNakagami/regmonkey_gitcommand.git
    ```

2. **[Optional]: dependency check**

    If you need to check dependencies, please run:

    ```bash
    bash ./setup_dependency.sh
    ```

3. **setup path**

    write the fowllowing line in your `.zshrc` or `.bashrc`

    ```bash
    export PATH="$PATH:$HOME/.tool.d/regmonkey_gitcommand/src"
    ```

4. **Permission**

    Make the scripts executable:

    ```bash
    chmod +x ~/.tool.d/regmonkey_gitcommand/src/*
    ```

## Uninstall

1. Delete the directory `~/.tool.d/regmonkey_gitcommand`
2. Delete the line `export PATH=$PATH:~/.tool.d/regmonkey_gitcommand/src` in your `.zshrc` or `.bashrc`

```bash
rm -rf ~/.tool.d/regmonkey_gitcommand
```

## RECOMMENDATION: Update your a gitconfig

To enhance your Git experience with some convenient aliases, please add the following lines to your `.gitconfig` file:

```ini
[alias]
  # regmonkey_gitcommand
  add-newline = "!git-add-newline.sh"
  add-patch = "!git-add-patch.sh"
  issue2pr = "!git-issue2pr.sh"
  browse = "!git-browse.sh"
  check-commitsize = "!git-check-commitsize.sh"
  lastdiff = "!git-lastdiff.sh"
  newline-check = "!git-newline-check.sh"
  tree = "!gtree.sh"
  tmp-checkout = "!git-tmp-checkout.sh"
  whoami = "!git-whoami.sh"
  sprint-commit = "!git-sprint-commit.sh"
```

These aliases provide shortcuts for common commands, making your workflow more efficient.
For example, `git check-commitsize` will run the `git-check-commitsize` command, and git tree will run the gtree command.

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Contact

For any questions or suggestions, please open an issue or contact the repository owner.
