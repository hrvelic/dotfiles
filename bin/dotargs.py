import sys

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

    return arguments, {"test": is_test, "verbose": is_verbose}

