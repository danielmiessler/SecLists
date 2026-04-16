# SQLi Payloads (Risk-Classified from sqlmap)

SQL injection payloads extracted from the [sqlmap payload definitions](https://github.com/sqlmapproject/sqlmap/tree/master/data/xml/payloads) and split by the same risk levels sqlmap itself uses. Addresses [issue #1011](https://github.com/danielmiessler/SecLists/issues/1011): the need for a safer SQLi wordlist that won't destroy data when fuzzed against `UPDATE` or `DELETE` statements.

## Why Risk Levels Matter

A generic SQLi wordlist will cheerfully fire `OR 1=1` at every parameter it finds. If one of those parameters happens to be the `WHERE` clause of a `DELETE` or `UPDATE` query, the result is that the condition becomes true for every row in the table and the whole table gets wiped or mass-updated. This has happened enough times in the real world that sqlmap categorises its own payloads by risk and defaults to risk level 1.

The three risk levels used below match sqlmap's `--risk` option:

- **Low-Risk (risk=1)**: `AND`-based conditions, safe `CASE WHEN` wrappers, and other payloads that either do nothing or produce a predictable truthy/falsy result. Fine to fire at any parameter you're not sure about. Default for sqlmap.
- **Medium-Risk (risk=2)**: Heavy time-based blind payloads that can spike server resource usage. Not data-destructive but may slow or stress the target.
- **High-Risk (risk=3)**: `OR`-based payloads and similar constructs that make the condition match every row. Only use these against parameters you have confirmed are in a read-only (`SELECT`) context, never blindly against unknown endpoints.

## Layout

```
Low-Risk-Payloads/
    boolean_blind.txt      AND-based boolean blind
    error_based.txt        error-triggering expressions
    inline_query.txt       inline SELECT payloads
    stacked_queries.txt    stacked-query payloads (risk=1 subset)
    time_blind.txt         time-based blind (risk=1 subset)
Medium-Risk-Payloads/
    stacked_queries.txt    stacked queries that modify server state
    time_blind.txt         heavy time-based blind
High-Risk-Payloads/
    boolean_blind.txt      OR-based boolean blind
    error_based.txt        OR-based error-triggering
    time_blind.txt         OR-based time blind
```

UNION query tests are not included here because sqlmap generates them dynamically from a column range rather than from fixed payloads.

## Placeholders

The payloads are kept verbatim from sqlmap, which means they contain placeholder tokens that sqlmap substitutes at runtime:

| Placeholder | Meaning | Reasonable substitute |
|---|---|---|
| `[RANDNUM]`, `[RANDNUM1]`, `[RANDNUM2]` | Random integer | any integer, e.g. `4444` |
| `[RANDSTR]` | Random alphanumeric string | any short string, e.g. `abcd` |
| `[ORIGVALUE]` | Original value of the injected parameter | whatever the legitimate value is |
| `[SLEEPTIME]` | Delay in seconds for time-based payloads | `5` |
| `[INFERENCE]` | Boolean expression compared in blind tests | `1=1` |
| `[DELIMITER_START]`, `[DELIMITER_END]` | String boundary markers used for error-based detection | any short unique tokens |
| `[GENERIC_SQL_COMMENT]` | SQL comment terminator | `-- -` |

If you're feeding these into a generic fuzzer that doesn't understand sqlmap placeholders, substitute them before use or pre-process with `sed`.

## Suggested Usage

- Start with `Low-Risk-Payloads/` against any unknown endpoint.
- Only move to `Medium-Risk-Payloads/` or `High-Risk-Payloads/` once you've confirmed the parameter is in a read-only context, or on a non-production target where data loss is acceptable.
- If you're using sqlmap itself, you don't need this folder at all; pass `--risk=1` (default) or the appropriate risk level and sqlmap will pick the right payloads.

## Source and Updates

Payloads were extracted from the upstream sqlmap repository's `data/xml/payloads/*.xml` files. sqlmap updates these occasionally, so these wordlists may drift from upstream over time.

## License

Same license as sqlmap itself (GPL v2). See the [sqlmap license](https://github.com/sqlmapproject/sqlmap/blob/master/LICENSE) for details.
