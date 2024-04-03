# !/usr/bin/env python
"""This script serves to act as a global funtion for title casing strings from the command line. Moreso, its intended to be used from within Neovim."""

import sys


def main(string: str):
    titled_string = title_func(string)
    print(titled_string)


"this is my test line"


def title_func(string: str):
    return string.title()


def check_arg_length():
    if len(sys.argv) != 1:
        print("Usage: python title.py")
        sys.exit(1)


if __name__ == "__main__":
    string = sys.argv[1]
    main(string)
