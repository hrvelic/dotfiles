#!/usr/bin/env python

import sys
from os import path
from enum import Enum, auto
from dotargs import parse_arguments
from linker import install_links_to_home
from fileops import execute_file_operations


def exit_with_message(message):
    print(message)
    sys.exit(1)


def print_usage_and_exit():
    exit_with_message("""Usage:
  To link dotfiles into user's home directory (existing files will be backed up):
  $ dotinstall.py home

  NOTE: dotfiles ending with ".disabled" in dotfiles repo will be ignored by any operation.

  Options:
    --test    - don't perform actions, just print them out
    --verbose - very verbose output, useful for debugging
""")


class ScriptAction(Enum):
    HOME = auto()
    NO_COMMAND = auto()
    INVALID_COMMAND = auto()


commands, options = parse_arguments()
script_action = ScriptAction.NO_COMMAND

if len(commands) == 1 and commands[0] == "home":
    script_action = ScriptAction.HOME
elif len(commands) > 0:
    script_action = ScriptAction.INVALID_COMMAND

if script_action == ScriptAction.NO_COMMAND:
    print("No command specified.")
    print_usage_and_exit()
elif script_action == ScriptAction.INVALID_COMMAND:
    print("Invalid command(s):", ",".join(commands))
    print_usage_and_exit()
elif script_action != ScriptAction.HOME:
    print("Internal Error: Unknown action code {}".format(script_action))


is_dryrun = options.get("test")
is_verbose = options.get("verbose")
file_operations = install_links_to_home(
    path.normpath(path.join(path.dirname(path.realpath(__file__)), "../home")),
    ".dotfiles",
    is_verbose
)

if len(file_operations) == 0:
    exit_with_message("Nothing to do: everything up to date. Exiting.")

if is_verbose:
    print("Prepared file operations:")
    for operation in file_operations:
        print("Operation: [" + str(operation) + "].")
    print("Executing file operations...")

execute_file_operations(file_operations, is_dryrun, True)
