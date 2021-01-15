# Hrvoje Velic's dotfiles

As the title says.

# Installation

Requires `python` interpreter in path. You can run the following commands:
* `bin/dotinstall.py home` to link home directory dot files into your user's home directory. A link to `dotfiles/home` will be created as `.dotfiles` in user directory and every other file will be linked through it. Existing correct link will be skipped and previous files will be backed up.

Additional options:
* `--test` to only prepare for operations but not execute them
* `--verbose` for very verbose printout of what the script is doing, useful for debugging

## Ignoring files

If a dot file in the project has `.disabled` extension it will be ignored for all operations. 

# Todo

- [ ] script to copy project type specific dot files into current directory
