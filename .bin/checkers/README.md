All the files here will be run by `validators.sh` as part of the check pipeline

## Specifications
Scripts will be passed a space separated list of files to check
e.g `./script.sh "Discovery/Web-Content/trickest-robots-disallowed-wordlists/top-100.txt"`

If you want your output to be parsed by the caller script, follow the below specs,else the output will be displayed raw in actions summaries

## Wrapped calls

### Wrapped calls checks

- - -

Scripts should check if its being run by the caller script. The environment variable `IS_RUNNING_UNDER_CALLER_SCRIPT` will be set to one

### Wrapped calls Specifications

- - -

Checker scripts will now have to print out the name of the check followed by a new line

Example `New line checker`

This value will be used as the checker title

After that, the descriptions will need to be printed out

Example `To fix the error, you have to remove the empty lines or new lines at the end of the file`

This is for contributors to understand why the checks failed

- - -

Outputs from now on will have to be in separate lines for each warnings or errors

This is the format for errors

Example `E,filename,line_number`

In the above example, `E` stands for errors. Accepted values are `E` and `W` for errors and warnings respectively

filename is the name of the file that the error comes from.

line_number is the line the script detected the error in.