# Auditing php source code with grep

## XSS
`grep -Ri "echo" *`

`grep -Ri "\$_" * | grep "echo"`

`grep -Ri "\$_GET" * | grep "echo"`

`grep -Ri "\$_POST" * | grep "echo"`

`grep -Ri "\$_REQUEST" * | grep "echo"`


- - -


## SQL Injection
`grep -Ri "$sql" *`

`grep -RI "mysqli(" *`

`grep -Ri "pdo(" * `


- - -



## File inclusion
`grep -Ri "file_include(" * `

`grep -Ri "file_get_contents(" * `

`grep -Ri "include(" *`


- - -


## Command execution
`grep -Ri "shell_exec(" *`

`grep -RIt "system(" *`

`grep -Ri "exec(" * `
