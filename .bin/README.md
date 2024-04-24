This is SecLists script directory where stuff like automated tasks and cleaner scripts can be found. You are welcome to use them to modify files here to your liking.

Below are scripts you can use to clean/modify/mutate files to your liking

- - -

`swear-words-remover.py` removes swear words from a target directory and outputs them in the same root directory as the passwords

e.g. target dir is `Passwords/Common-Credentials` and suffix is `-without-curse-words` so passwords will be in `Passwords/Common-Credentials`

- - -

`os-names-mutate.py` mutates `Fuzzing/os-names.txt` to include possible mutations of OS names in a url.

By default this script outputs the results in `Fuzzing/os-names-mutated.txt`

- - -

`xml-parser.py` parses xml files given as arguments and extracts hardcoded tags. It's meant to be modified as per file basis as every xml file format is unique.