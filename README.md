Outdated, will be rewritten in the future!

# ShellSmith Workspace

This repository serves as a workspace for [ShellSmith](https://github.com/marjohnsen/shellsmith), a tool designed to automate system configuration and should work on most Linux based operative system.

## Getting Started

1. Fork this repository.

2. Clone the forked repository to your local machine.

    ```bash
    git clone https://github.com/<your-github-username>/<forked-repo-name>.git
    ```

3. Enter the repository and run the `install.sh` script.

    ```bash
    cd <forked-repo-name> && ./install.sh
    ```

## Command Line Interface

After installation, run 'smith help' for more instructions.

## Workspace Workflow

The workspace contain three main directories and one submodule:

`app/` - Contains the user defined scripts executable through `smith run`

`dotfiles/` - a directory to store dotfiles

`misc/` - a directory to store miscellaneous files

`.shellsmith/` - a submodule containing the ShellSmith itself

You can of course add more directories as you see fit..

### Environment Variables

The following environment variables are available to you when executing the scripts through `shell run`:

`$SHELLSMITH_ROOT` - Path to the ShellSmith repo itself. This is also a submodule of the workspace.<br>
`$SHELLSMITH_WORKSPACE` - Path to the workspace repo<br>
`$SHELLSMITH_DOTFILES` - Path to `dotfiles/`<br>
`$SHELLSMITH_APPS` - Path to `app/`<br>
`$SHELLSMITH_MISC` - Path to `misc/`<br>
`$SHELLSMITH_UTILS` - Path to `.shellsmith/utils/`<br>

### Utility Functions

Several utility functions are available from `$SHELLSMITH_UTILS`:

*safe_symlink:* Safely creates a symlink by first checking if the destination exists and if it does, prompts the user to overwrite it.

```bash
source "$SHELLSMITH_UTILS/safe_symlink.sh"
safe_symlink <path-to-source> <path-to-destination>
```

*mason_build_and_ninja_install*: builds and installs a package using mason and ninja from a git repository, optional tag, and submodules.

```bash
source "$SHELLSMITH_UTILS/mason_build_and_ninja_install.sh"
mason_build_and_ninja_install "<main github repo> <optional tag>" \
                              "<github repo 1st submodule> <optional tag>" \
                              "<github repo 2nd submodule> <optional tag>" \
                              ...
```

### Declare dependencies

Dependencies are listed directly below the shebang using `:` followed by a space. Each dependency corresponds to a script in `apps/` without the `.sh` extension. For example:  

```bash
#!/bin/bash
: app1 app2 app3
```  

When running `smith run`, ShellSmith will prompt you to install the dependencies in the correct order.

### Execute user defined scripts

Any `.sh` script in the `apps/` directory is executable through the terminal user interface in `smith run`.

### `apps/init.sh`

Will always be executed first if choosen. Can be used to install stuff from package managers, initial setup, etc..

### Best practices

Try to write the scripts such that they can be executed multiple times without causing issues. This is especially important for the `apps/init.sh` script. I tend to start every script by trying to remove the current configuration before intalling the new one.Conveniently, I can easily update the configuration by running the script again.
