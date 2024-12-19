# regmonkey_gitcommand

- This repository contains a collection of useful Git commands and scripts to help manage and automate your Git workflow.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#ffa657;'>
<strong style="color:#ffa657">Scope</strong> <br>

- This repository is primarily intended for use on Linux or macOS systems.

</div>

## Dependency

|command|Ubuntu|MacOS|
|---|---|---|
|`tree`|`apt install tree`|`brew install tree`|

## Install

1. **Clone the repository**:

    ```bash
    git clone https://github.com/yourusername/regmonkey_gitcommand.git
    ```

2. **run install.sh**

    ```bash
    bash ./install.sh
    ```

    When you run the above script, `~/.tool.d/regmonkey_gitcommand` will be created and the shellscripts be stored in the direcotry

3. **[Optional]: dependency check**

    If you need to check dependencies, please run:

    ```bash
    bash ./setup_dependency.sh
    ```

4. **setup path**

    write the fowllowing line in your `.zshrc` or `.bashrc`

    ```sh
    export PATH="$PATH:$HOME/.tool.d/regmonkey_gitcommand"
    ```

## Uninstall

1. Delete the directory `~/.tool.d/regmonkey_gitcommand`
2. Delete the line `export PATH=$PATH:~/.tool.d/regmonkey_gitcommand` in your `.zshrc` or `.bashrc`

```bash
rm -rf ~/.tool.d/regmonkey_gitcommand
```

## RECOMMENDATION: Update your a gitconfig

To enhance your Git experience with some convenient aliases, please add the following lines to your `.gitconfig` file:

```txt
[alias]
 # regmonkey_gitcommand
 check-commitsize = "!git-check-commitsize"
 tree = "!git-tree"
 lastdiff = "!git-lastdiff"
 tmp-checkout = "!git-tmp-checkout"
 whoami = "!git-whoami"
```

These aliases provide shortcuts for common commands, making your workflow more efficient.
For example, `git check-commitsize` will run the `git-check-commitsize` command, and git tree will run the gtree command.

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Contact

For any questions or suggestions, please open an issue or contact the repository owner.
