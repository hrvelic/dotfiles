#!/usr/bin/env python

import sys
import os
from os import path
from enum import Enum, auto


def exit_with_message(message):
    print(message)
    sys.exit(1)


usage = """Usage:
  To link dotfiles into user's home directory (existing files will be backed up):
  $ dotinstall.py home

  To copy each project's dotfiles into current directory 
  $ dotinstall.py <space delimited project names>

  NOTE: dotfiles ending with ".disabled" in dotfiles repo will be ignored by any operation.

  Options:
    --test    - don't perform actions, just print them out
"""

if len(sys.argv) <= 1:
    exit_with_message(usage)

dotfiles_directory = path.normpath(path.join(path.dirname(path.realpath(__file__)), "../"))
dotfiles_link_name = ".dotfiles"
home_dir_name = "home"
install_home = False
non_project_error = False
test_option = "--test"

##################################################################################
# File operations

class FileOperation(Enum):
    SKIP = auto()
    BACKUP = auto()
    SYMLINK = auto()
    MKDIR = auto()


def validate_operation(code, expected_code):
    if code != expected_code:
        exit_with_message("Invalid operation! Expected {} but got {}".format(expected_code, code))


def exec_skip_file(operation, is_test, verbose):
    code, file_path = operation
    validate_operation(code, FileOperation.SKIP)
    print("Skipping", file_path)


def backup_name(file_path, backup_index=None):
    if backup_index == None:
        result = file_path + ".backup"
    else:
        result = file_path + ".backup" + str(backup_index)

    return result


def exec_backup_file(operation, is_test, verbose):
    code, file_path = operation
    validate_operation(code, FileOperation.BACKUP)
    backup_path = backup_name(file_path)
    backup_counter = 0
    while (path.lexists(backup_path)):
        backup_counter += 1
        backup_path = backup_name(file_path, backup_counter)

    print("Backing up", file_path, "to", backup_path)
    if not is_test:
        os.rename(file_path, backup_path)


def exec_symlink(operation, is_test, verbose):
    code, link_path, file_path = operation
    validate_operation(code, FileOperation.SYMLINK)
    print("Linking", link_path, "->", file_path)
    if not is_test:
        os.symlink(file_path, link_path, target_is_directory=path.isdir(file_path))


def exec_makedir(operation, is_test, verbose):
    code, dir_name = operation
    validate_operation(code, FileOperation.MKDIR)
    print("Creating directory", dir_name)
    if not is_test:
        os.makedirs(dir_name)


file_operation_switcher = {
    FileOperation.SKIP: exec_skip_file,
    FileOperation.BACKUP: exec_backup_file,
    FileOperation.SYMLINK: exec_symlink,
    FileOperation.MKDIR: exec_makedir,
}


def execute_file_operation(operation, is_test, verbose):
    operation_fn = file_operation_switcher.get(operation[0])
    operation_fn(operation, is_test, verbose)


def skip_file(file_path):
    return (FileOperation.SKIP, file_path)


def backup(file_path):
    return (FileOperation.BACKUP, file_path)


def symlink(link_path, file_path):
    return (FileOperation.SYMLINK, link_path, file_path)


def mkdir(dir_path):
    return (FileOperation.MKDIR, dir_path)


##################################################################################
# Link dot files

def backup_if_exists(file_path, verbose):
    result = []
    if path.lexists(file_path):
        result.append(backup(file_path))
    else:
        if verbose:
            print("No backup, doesn't exist:", file_path)

    return result


def link_if_not_linked(link_path, target_path, verbose):
    if verbose:
        print("Link check input", link_path, target_path)

    norm_target_path = path.abspath(path.expanduser(target_path))
    if verbose:
        print("Link check normalized", link_path, norm_target_path)

    if path.exists(link_path) and path.samefile(link_path, norm_target_path):
        # Valid link already exists
        if verbose:
            print("Already linked", link_path)

        # return [skip_file(link_path)]
        return []

    if verbose:
        print("Requires linking", link_path)
    result = []
    result += backup_if_exists(link_path, verbose)
    result.append(symlink(link_path, norm_target_path))
    return result


home_directory = path.expanduser("~")

def home_rel_path(target_path):
    return path.join("~", path.relpath(target_path, home_directory))


def recursively_link_files(link_directory, file_directory, shortcut_directory, verbose):
    file_operations = []
    for filename in os.listdir(file_directory):
        # skip files and directories ending with .disabled
        if filename.endswith(".disabled"):
            continue
        link_file_path = path.join(link_directory, filename)
        file_path = path.join(file_directory, filename)
        shortcut_path = path.join(shortcut_directory, filename)
        if path.isdir(file_path):
            # Recurse into directories, and link files in them
            subdir_operations = recursively_link_files(
                link_file_path, file_path, shortcut_path, verbose)
            if not path.isdir(link_file_path) and len(subdir_operations) > 0:
                # Only create directories if there were files to link in them
                file_operations += backup_if_exists(link_file_path, verbose)
                file_operations.append(mkdir(link_file_path))

            file_operations += subdir_operations
        else:
            file_operations += link_if_not_linked(link_file_path, shortcut_path, verbose)

    return file_operations


def install_links_to_home(verbose):
    print("Linking dot files in user's home directory...")
    dotfiles_dir_link = path.join(home_directory, dotfiles_link_name)
    dotfiles_home_dir = path.normpath(path.join(dotfiles_directory, home_dir_name))
    file_operations = []
    if verbose:
        print("home directory", home_directory)
        print("dotfile dir link", dotfiles_dir_link)
        print("dotfiles home dir", dotfiles_home_dir)

    # Link .dotfiles in user's home
    file_operations += link_if_not_linked(
      dotfiles_dir_link,
      home_rel_path(dotfiles_home_dir),
      verbose
    )

    # link dot files from dotfiles/home into user's home via .dotfiles link
    file_operations += recursively_link_files(
        home_directory,
        dotfiles_home_dir,
        home_rel_path(dotfiles_dir_link),
        verbose
    )
    return file_operations


##################################################################################
# Copy dot files

def copy_projects_to_cwd(projects, verbose):
    # print("Copying dotfiles for project types", ",".join(projects), "...")
    # TODO Implement
    exit_with_message("ERROR: Not implemented yet.")
    return []


##################################################################################
# Script

class ScriptAction(Enum):
    HOME = auto()
    PROJECTS = auto()
    PROJECTS_NOT_FOUND = auto()
    ILLEGAL_PROJECTS = auto()


def parse_arguments():
    arguments = []
    is_test = False
    is_verbose = False
    for option in sys.argv[1:]:
        if option == "--test":
            is_test = True
            continue
        if option == "--verbose":
            is_verbose = True
            continue
        arguments.append(option)

    arg_options = {"test": is_test, "verbose": is_verbose}

    if len(arguments) == 1 and arguments[0] == home_dir_name:
        return ScriptAction.HOME, [], arg_options

    non_project_dirs = ["bin", "_WIP", home_dir_name]
    found_projects = []
    for item in arguments:
        if item in non_project_dirs:
            return ScriptAction.ILLEGAL_PROJECTS, [item], arg_options

        file_path = path.join(dotfiles_directory, item)
        if not path.exists(file_path):
            return ScriptAction.PROJECTS_NOT_FOUND, [item], arg_options

        found_projects += file_path

    return ScriptAction.PROJECTS, found_projects, arg_options


action_code, items, options = parse_arguments()
test_mode = options.get("test")
verbose_mode = options.get("verbose")
operations = []

if action_code == ScriptAction.ILLEGAL_PROJECTS:
    exit_with_message("Error: not a valid project type name: " + ", ".join(items) + ". Exiting.")
if action_code == ScriptAction.PROJECTS_NOT_FOUND:
    exit_with_message("Error: project type(s) not found: " + ",".join(items) + ". Exiting.")
if action_code == ScriptAction.HOME:
    operations = install_links_to_home(verbose_mode)
if action_code == ScriptAction.PROJECTS:
    if len(items) == 0:
        exit_with_message(usage)
    operations = copy_projects_to_cwd(items, verbose_mode)

for operation in operations:
    if verbose_mode:
        print("Operation: [" + str(operation) + "].")
    execute_file_operation(operation, test_mode, verbose_mode)
