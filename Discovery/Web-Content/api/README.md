# api_wordlist
A wordlist of API names used for fuzzing web application APIs.

## Contents
* api_seen_in_wild.txt - This contains API function names I've seen in the wild.
* actions.txt - All API function name verbs
* objects.txt - All API function name nouns
* actions-uppercase.txt - API function name verbs with leading character upper-case
* actions-lowercase.txt - API function name verbs with leading character lower-case
* objects-uppercase.txt - API function name nouns with leading character upper-case
* objects-lowercase.txt - API function name nouns with leading character lower-case
* api-endpoints-res.txt - Combination of all of the files above

## Usage
 1. In burpsuite, send an API request you want to fuzz to Intruder. 
 2. Remove the existing API function call, and replace it with two § characters for each text file you want to use.
 3. On the "Positions" tab, set Attack type to "Cluster Bomb".
 4. On the "Payloads" tab, select 1 for the fist Payload set drop-down, then select a Payload type of "Runtime file" and navigate to the directory you downloaded these text files to. Select "actions.txt".
 5. Repeat step 4 by setting Payload set 2 to "objects.txt".
 6. (optional step - add more payload sets and set them to "objects.txt" to test for multi-part objects like "UserAccount")
 7. Start attack!

## Comments
If you use this and it's helpful, I'd love to hear about it! (@dagorim). If you think I've missed any obvious word choices, I'd love to hear about that as well, or feel free to add them.
