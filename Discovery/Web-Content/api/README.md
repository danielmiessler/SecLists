# API Wordlist

A wordlist of API names used for fuzzing web application APIs.

## api_seen_in_wild.txt

### Overview
This file contains API function names that have been observed in the wild.

### Usage
Use for: fuzzing web application APIs

### Source
Source: Collected from various sources

## actions.txt

### Overview
This file contains all API function name verbs.

### Usage
Use for: fuzzing web application APIs

### Source
Source: Collected from various sources

## objects.txt

### Overview
This file contains all API function name nouns.

### Usage
Use for: fuzzing web application APIs

### Source
Source: Collected from various sources

## actions-uppercase.txt

### Overview
This file contains API function name verbs with the leading character in upper-case.

### Usage
Use for: fuzzing web application APIs

### Source
Source: Collected from various sources

## actions-lowercase.txt

### Overview
This file contains API function name verbs with the leading character in lower-case.

### Usage
Use for: fuzzing web application APIs

### Source
Source: Collected from various sources

## objects-uppercase.txt

### Overview
This file contains API function name nouns with the leading character in upper-case.

### Usage
Use for: fuzzing web application APIs

### Source
Source: Collected from various sources

## objects-lowercase.txt

### Overview
This file contains API function name nouns with the leading character in lower-case.

### Usage
Use for: fuzzing web application APIs

### Source
Source: Collected from various sources

## api-endpoints-res.txt

### Overview
This file is a combination of all the files above.

### Usage
Use for: fuzzing web application APIs

### Source
Source: Collected from various sources

## Usage Instructions

1. In Burp Suite, send an API request you want to fuzz to Intruder.
2. Remove the existing API function call, and replace it with two § characters for each text file you want to use.
3. On the "Positions" tab, set Attack type to "Cluster Bomb".
4. On the "Payloads" tab, select 1 for the first Payload set drop-down, then select a Payload type of "Runtime file" and navigate to the directory you downloaded these text files to. Select "actions.txt".
5. Repeat step 4 by setting Payload set 2 to "objects.txt".
6. (Optional step - add more payload sets and set them to "objects.txt" to test for multi-part objects like "UserAccount")
7. Start the attack!

## Comments

If you use this and it's helpful, I'd love to hear about it! (@dagorim). If you think I've missed any obvious word choices, I'd love to hear about that as well, or feel free to add them.
