# Wordlist updaters

## Overview
The purpose of the scripts are to update wordlists from remote sources defined in sources.json.

A github action should check every hour to see if the update conditions are met, then updates accordingly

`status.json` is not meant to be edited in a pr.

## Format

Example sources.json

```json
[
    {
        "name": "Jwt secrets update",
        "type": "file",
        "source": "https://raw.githubusercontent.com/wallarm/jwt-secrets/master/jwt.secrets.list",
        "output": "Passwords/scraped-JWT-secrets.txt",
        "post_run_script": "",
        "frequency": "3h"
    }
]
```

All fields are required unless otherwise stated.

`name` is the name of the task.

`type` can be one of the following: `file, git_dir`.

`source` specify the remote location. If type is `git_dir`, the folder at that location will be cloned using git.

`frequency` is the update frequency. The script will use the `status.json` file to know when to update. Accepted units of time are `h,H` for hours and `d,D` for days. Frequency can be specified with only days or hours, or with both of them. Hours cannot be before days. (`6h1d`)

`update_time` specifies the daily frequency in utc 24 hour syntax (0300). Only one update frequency field can be set at a time. (`frequency` or `update_time`)

`output` is the output file/dir the script will put the output in.

`post_run_script` is the script to be run after pulling the list successfully. This field is optional.

`additional_paths` is the additional paths that the workflow script should alert if there is a pull request for the file. This field is optional and won't be used for the updater, but rather the checker.

- - -

Example status.json

```json
{
    "Jwt secrets update": {
        "last_update" : 0
    }
}
```

