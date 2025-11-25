## Java-Spring-Boot.txt
Use for: Detecting actuator endpoints, and testing for RCEs in Spring-Boot instances.

Note that it's possible for a spring-boot backend to be behind a spring-cloud-gateway, which may _only_ route all traffic prefixed with `/api/` to the backend. Consider fuzzing the starting prefix `api` with many different values to find what reaches the backend. A recommended wordlist to fuzz this value with is at `Fuzzing/Miscellaneous/schemes.txt`