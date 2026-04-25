# SQL Injection wordlists
> [!CAUTION]
> Many of these wordlists contain potentially destructive queries which may permanently delete data on any databases they're used on. For more information see [issue #1011](https://github.com/danielmiessler/SecLists/issues/1011)

For a safer starting set, see [`sqlmap-risk-classified/`](sqlmap-risk-classified/). It ships a small Python script that pulls sqlmap's payload XMLs and writes them to disk split by sqlmap's own risk level (1/2/3), so you can pick low-risk payloads first.