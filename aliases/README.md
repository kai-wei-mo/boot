# Aliases

This directory contains aliases that I use in my shell.

To use them, aliases may be appended to your shell's configuration file (e.g. `~/.bashrc` or `~/.zshrc`).

## Alias Files

`generic.sh` has some aliases for basic UNIX commands.
`kubectl.sh` has some aliases for kubectl.

## Scripts

`_aliases_directory.sh` creates the directory `~/.aliases` (if it does not already exist) and copies all alias files in this directory to `~/.aliases`. It also adds `source ~/.aliases` to your shell('s/s) configuration files if it is not already present.

`_append_aliases.sh` appends all alias files to your shell('s/s) configuration files. It is not idempotent.
