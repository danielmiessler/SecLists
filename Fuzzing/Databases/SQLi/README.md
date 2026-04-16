# SQL Injection wordlists
> [!CAUTION]
> Many of these wordlists contain potentially destructive queries which may permanently delete data on any databases they're used on. For more information see [issue #1011](https://github.com/danielmiessler/SecLists/issues/1011)

For a safer starting point, see [`sqlmap-risk-classified/`](sqlmap-risk-classified/README.md), which splits sqlmap's payloads into `Low-Risk`, `Medium-Risk`, and `High-Risk` groups so you can avoid firing `OR`-based payloads at `UPDATE`/`DELETE` queries by accident.