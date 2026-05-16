This directory contains payloads from [the sqlmap project](https://github.com/sqlmapproject/sqlmap) which are sorted automatically by a script (located at the `.bin` directory at the base of this repository).

From [the SQLMap documentation](https://github.com/sqlmapproject/sqlmap/wiki/Usage#risk):

> All payloads are divided into three risk levels. The default value is 1 which is innocuous for the majority of SQL injection points. Risk value 2 adds to the default level the tests for heavy query time-based SQL injections and value 3 adds also OR-based SQL injection tests.
> 
> In some instances, like a SQL injection in an UPDATE statement, injecting an OR-based payload can lead to an update of all the entries of the table, which is certainly not what the attacker wants. For this reason and others this option has been introduced: the user has control over which payloads get tested, the user can arbitrarily choose to use also potentially dangerous ones.

In this directory, the risk levels are named as follows:
- Risk level 1 = `Low-Risk-Payloads/`
- Risk level 2 = `Medium-Risk-Payloads/`
- Risk level 3 = `High-Risk-Payloads/`


> [!IMPORTANT]
> The classified payloads still contain sqlmap placeholders. Before being sent into any automated tool, the placeholders should be replaced.

| Placeholder | Replace with |
| --- | --- |
| `[RANDNUM]`, `[RANDNUM1]`, `[RANDNUM2]` | any integer |
| `[RANDSTR]` | any short alphanumeric string |
| `[ORIGVALUE]` | the legitimate value of the param |
| `[SLEEPTIME]` | seconds for time-based payloads, e.g. 5 |
| `[INFERENCE]` | a boolean expression like `1=1` |
| `[GENERIC_SQL_COMMENT]` | `-- -` |
| `[DELIMITER_START]`, `[DELIMITER_END]` | any short unique tokens |
<br>

> [!NOTE]
> From the original repository, the payloads from `union_query.xml` are not included here as those are built from a column-count range at runtime.

---

All payloads in this directory are licensed under the SQLMap project license, the [GPL v2](https://github.com/sqlmapproject/sqlmap/blob/master/LICENSE).