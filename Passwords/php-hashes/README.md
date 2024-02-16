# PHP magic hashes

PHP has some unique features which makes hash collisions more easier when using the `==` to compare.

The raw text are taken directly from [spaze/hashes](https://github.com/spaze/hashes/)

- - -

### Floating comparison

Any strings that starts with any numbers of `0`, followed by `e` then ends with only numbers will be treated as zero. An example of such strings are `0e123456` and `00e123456`. [Example code](https://3v4l.org/n8iOp)

This behavior can be extended to numbers, like `'0' == '000`. [Example code](https://3v4l.org/K9QRb)

With loose comparison, these two example strings will equate to each other as both of them are treated as a zero in the backend.

Sometimes, hashes of specific strings will result in those special strings as an result. Those hashes are called `magic hashes`

Here is an example of such weak comparison for [sha256](https://3v4l.org/Lu7tm).

- - -

### Plaintext

Plaintext.txt just contains some ways to abuse php's weak comparison

- - -

### Truncated text

For bcrypt, passwords are automatically truncated to 72 characters, so as long as the first 72 characters match, the hashes will match.

[Bcrypt example](https://3v4l.org/MsfS0)

Descrypt have similar behavior to bcrypt, but passwords are instead truncated to 8 characters.
