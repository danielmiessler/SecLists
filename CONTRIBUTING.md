## Contributing

If you have any ideas for things we should include, please use ONE of the following methods to submit them:

* Send us pull requests
* Create an issue in the project (with links, and we'll parse and incorporate them)
* Email `daniel.miessler@owasp.org` or `jason.haddix@owasp.org` with content to add

Significant effort SHOULD be made to give attribution for these lists whenever possible, and if you are a list owner or know who the original author/curator is, please let us know so we can give proper credit.

## Folder naming scheme

Folders should be named with the train case scheme, for example `File-System`.

## READMEs

If you are uploading a brand-new wordlist into SecLists, an entry must be added to the containing folder's `README.md`. If the folder does not already have a `README.md` file, you may create one.

These are the general guidelines for writing READMEs in SecLists:
1. Use the filename of the wordlist as the title. This will help other people more easily locate which entries in the README correspond to the wordlist you've uploaded.
2. If the wordlist is very purpose-specific, consider adding a `Use for:` text, right below the entry title. For example: 
> ## vulnerability-scan_j2ee-websites_WEB-INF.txt
> Use for: Discovering sensitive J2EE files, allowing for exploitation of an LFI.

3. Always include a link to the source of the wordlist: `Source: example.com/the-great-wordlist`
4. If the author shared the wordlist through a blogpost, include a link to it: `Reference: example.com/how-i-hacked-xyz-with-a-wordlist`. This will help SecLists users more easily understand the practical applications of the wordlists you've uploaded.

You can use the README in the folder [Web-Content](Discovery/Web-Content) as a general reference.
