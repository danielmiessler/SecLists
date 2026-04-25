# sqlmap risk-classified SQLi payloads

This folder doesn't ship the wordlists themselves. Run `generate.py` and it
pulls sqlmap's payload XMLs and writes the wordlists into
`Low-Risk-Payloads/`, `Medium-Risk-Payloads/`, `High-Risk-Payloads/` next to
the script.

```
python3 generate.py
```

For air-gapped use, point it at a local sqlmap checkout:

```
python3 generate.py --offline /path/to/sqlmap/data/xml/payloads
```

## What the risk levels mean

Same meaning as sqlmap's own `--risk` option:

* Risk 1 (Low): AND-based and CASE-WHEN payloads. Fine to fire at any
  parameter you don't yet understand. This is sqlmap's default.
* Risk 2 (Medium): heavy time-based payloads. Not destructive, but they hold
  the connection open and can stress the target.
* Risk 3 (High): OR-based payloads. The condition matches every row, which
  matters if the parameter ends up in an UPDATE or DELETE WHERE clause.
  Don't fire these at unknown endpoints. Issue #1011 has the background.

## Placeholders kept verbatim from sqlmap

Payloads still contain sqlmap's tokens. If you're piping into a fuzzer that
doesn't substitute them, swap them out with `sed` first.

| Token | Replace with |
| --- | --- |
| `[RANDNUM]`, `[RANDNUM1]`, `[RANDNUM2]` | any integer |
| `[RANDSTR]` | any short alphanumeric string |
| `[ORIGVALUE]` | the legitimate value of the param |
| `[SLEEPTIME]` | seconds for time-based payloads, e.g. 5 |
| `[INFERENCE]` | a boolean expression like `1=1` |
| `[GENERIC_SQL_COMMENT]` | `-- -` |
| `[DELIMITER_START]`, `[DELIMITER_END]` | any short unique tokens |

## Why a script and not the files

So you can re-run it whenever sqlmap adds payloads upstream and not have to
wait for someone to update SecLists.

`union_query.xml` is skipped on purpose. sqlmap builds those at runtime from
a column-count range, there are no fixed strings to extract.

Source: https://github.com/sqlmapproject/sqlmap/tree/master/data/xml/payloads
License of the payload content: GPL v2 (sqlmap's license).
