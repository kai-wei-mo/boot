# Aliases

This directory contains aliases that I use in my shell.

To use them, aliases may be appended to your shell's configuration file (e.g. `~/.bashrc` or `~/.zshrc`).

## Alias Files

`generic.sh` has some aliases for basic UNIX commands.
`kubectl.sh` has some aliases for kubectl.

## Scripts

`aliases_setup.sh` creates the directory `~/.aliases` (if it doesn't already exist) and overwrites its content with `aliases_files`. It also adds `source ~/.aliases` to the shell configuration files (if it isn't already there).
