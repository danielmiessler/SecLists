# PasswordPermutator

## Requirements
* R installation
* R packages: data.table, stringi, Hmisc, english, stringr

## Usage
* > Rscript PP.R

## Processes
* Adds separator characters ('@', '!', '$', '-', '.', ':', '_', '%', '?')
* Converts integer numbers into word equivalents ('420', 'fourhundredtwenty', 'FOURTWOZERO', 'FourTwenty', etc.)
* Assembles all possible combinations of listed items

## Input
* list.txt - list of terms to process, one item per line

## Output
* PPFinal_R.txt - output when run
