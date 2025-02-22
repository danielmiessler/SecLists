#!/usr/bin/python
from __future__ import print_function
from codecs import open as copen
from os import listdir, path
from sys import argv

import unicodedata

# usage: utf8-fix.py PATH [codec] [normalize]
PATH = argv[1] if len(argv) > 1 else ""
NORMALIZE = False
ENCODING = None
DEFAULT_ENCODING = "iso8859_2"  # iso8859_2 a.k.a latin2

for arg in argv[2:]:
    if arg.lower() == "normalize":
        NORMALIZE = True
    else:
        ENCODING = arg



def convert_file(file_path):
    print("[*]", file_path, "fixed!")
    foriginal = copen(file_path, "r", "utf8", errors='ignore')
    content = foriginal.read()
    foriginal.close()

    ccontent = fix_encoding(content, ENCODING, NORMALIZE, True)
    fconverted = copen(file_path, "w", "utf8")
    fconverted.write(ccontent)
    fconverted.close()

def normalize_str(text):
    return ''.join(
        c for c in unicodedata.normalize('NFKD', text)
        if unicodedata.category(c) != 'Mn'
    )

def fix_encoding(content, encoding=None, norm=False, verbose=False):
    encoding = encoding or DEFAULT_ENCODING

    try:
        fixed = content.encode(encoding).decode("utf8")
    except:
        fixed = content
        if verbose:
            print("[*] error: can't fix the encoding. mixed encoding?")

    if norm:
        return normalize_str(fixed)
    else:
        return fixed


if __name__ == "__main__":
    if path.isfile(PATH):
        convert_file(PATH)

    elif path.isdir(PATH):

        for ffile in listdir(PATH):
            file_path = path.join(PATH, ffile)

            if path.isfile(file_path):
                convert_file(file_path)
    else:
        print(
            "[*] error: "
            "usage: %s FILE_OR_DIR_PATH [codec] [normalize]"
            %
            argv[0]
        )
