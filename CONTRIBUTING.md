## Contributing

If you have any ideas for things we should include, please use ONE of the following methods to submit them:

* Create a pull request
* Create an issue in the project (with links, and we'll parse and incorporate them)

Significant effort SHOULD be made to give attribution for these lists whenever possible, and if you are a list owner or know who the original author/curator is, please let us know so we can give proper credit.

## Folder naming scheme

Folders should be named with the train case scheme, for example `File-System`.

## Conventional Commits

All commits related to contributions to seclists are encouraged to use the [Conventional-Commits v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/) syntax

> The Conventional Commits specification is a lightweight convention on top of commit messages. It provides an easy set of rules for creating an explicit commit history; which makes it easier to write automated tools on top of. This convention dovetails with SemVer, by describing the features, fixes, and breaking changes made in commit messages.
>
> The commit message should be structured as follows:
```xml
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

For example:
```
feat(wordlist): Added "raft" wordlists by Google
```

Below is a flowchart which should assist you in selecting the best conventional-commits syntax for the commit messages of the contributions you wish to make.

```mermaid
flowchart TD
	start(You made a commit) --> f1
	f1{Does it affect a wordlist?}
	f1 --> |YES| q1A{Did you upload a\ncompletely new\nwordlist?}

	q1A --> |YES| q1A_opt1(Use the syntax:\nfeat&lpar;wordlist&rpar;: Added &quot;WORDLIST_NAME_HERE&quot; by AUTHOR_NAME_HERE)
	q1A --> |NO| q1B{Did you add\ncompletely new\ncontent to an existing\nwordlist?}
	
	q1B --> |YES| q1B_opt1(Use the syntax:\nfeat&lpar;wordlist&rpar;: Added _____ to &quot;WORDLIST_NAME_HERE&quot;)
	q1B --> |NO| q1C{Did you fix an error/\nmistake/oversight in an\nexisting wordlist?}
	
	q1C --> |YES| q1C_end(Use the syntax:fix&lpar;wordlist&rpar;: Fixed _____ in &quot;WORDLIST_NAME_HERE&quot;\nfix&lpar;wordlist&rpar;: Removed _____ from &quot;WORDLIST_NAME_HERE&quot;)
	q1C --> |NO| q1D{Did you perform a big operation\nwich affects all wordlists \nin a minor way?\nFor example: \n- Moving all wordlists from one \ndirectory to a new one\n- Changing the line-endings of\nall wordlists}

	q1D --> |YES| q1D_end(Use the syntax:\nchore&lpar;wordlist&rpar;: _____\n\nFor example:\n\nchore&lpar;wordlist&rpar;: Moved all file-extension wordlists to /Fuzzing/File-Extensions/)
	q1D --> |NO| support1(Ask a project-maintainer which commit type you should use)

	f1 --> |NO| f2{Does if affect a\nREADME file?}

	f2 --> |YES| q2A{Did you create a new\nREADME file?}

	q2A --> |YES| q2A_end(Use the syntax:\nfeat&lpar;docs&rpar;: Created documentation for ______)
	q2A --> |NO| q2B{Did you fix a typo?\nDid you improve the\nphrasing of a README?}

	q2B --> |YES| q2B_end(Use the syntax:\nchore&lpar;docs&rpar;: Fixed typo for _____ docs\nchore&lpar;docs&rpar;: Improved phrasing in ____ docs)
	q2B --> |NO| q2C{Did you add new \ncontent to an existing\nREADME?}

	q2C --> |YES| q2C_end(Use the syntax:\nfeat&lpar;docs&rpar;: Added documentation for ______)
	q2C --> |NO| q2D{Did you fix incorrect\ninformation in a \nREADME?}

	q2D --> |YES| q2D_end(Use the syntax:\nfix&lpar;docs&rpar;: Corrected _____\n\nFor example:\nfix&lpar;docs&rpar;: Corrected author name for the raft.txt wordlist)
	q2D --> |NO| support2(Ask a project-maintainer which commit type you should use)


	f2 --> |NO| q3A{Does it affect the CICD\npipelines? &lpar;github actions&rpar;}

	q3A --> |YES| q3B{Did you create a\ncompletely new\nautomation?}
	q3A --> |NO| support3(Ask a project-maintainer which commit type you should use)

	q3B --> |YES| q3B_end(Use the syntax:\nfeat&lpar;cicd&rpar;: Created ______)
	q3B --> |NO| q3C{Did you fix an error or \nfix a vulnerability in an \nexisting automation?}

	q3C --> |YES| q3C_end(Use the syntax:\nfix&lpar;cicd&rpar;: Fixed ______ in &quot;AUTOMATION_NAME_HERE&quot;\n\nFor example:\nfix&lpar;cicd&rpar;: Fixed permissions error in &quot;trickest-wordlist auto-updater&quot;)
	q3C --> |NO| q3D{Did you add \na new feature \nto an existing \nautomation?}

	q3D --> |YES| q3D_end(Use the syntax:\nfeat&lpar;cicd&rpar;: Added _____ to &quot;AUTOMATION_NAME_HERE&quot;\n\nFor example:\nfeat&lpar;cicd&rpar;: Added a file size checker to &quot;dangerous_wordlist_checker.sh&quot;)
	q3D --> |NO| q3E{Did you:\n- Fix a typo\n- Move a file\n- Add a code coment}

	q3E --> |YES| q3E_end(Use the syntax:\nchore&lpar;cicd&rpar;: Fixed typo in &quot;AUTOMATION_NAME_HERE&quot;\nchore&lpar;cicd&rpar;: Moved ______\nchode&lpar;cicd&rpar;: Added code comment to &quot;AUTOMATION_NAME_HERE&quot;)
	q3E --> |NO| support4(Ask a project-maintainer which commit type you should use)
```

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
