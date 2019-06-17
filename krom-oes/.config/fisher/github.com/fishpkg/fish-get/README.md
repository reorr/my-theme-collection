# fish-get

Interactive prompt reader and [`read`](http://fishshell.com/docs/current/commands.html#read) builtin companion for the [fish shell](https://fishshell.com).

## Installation

With [Fisher](https://github.com/jorgebucaran/fisher)

```
fisher add fishpkg/fish-get
```

## Options

- `-p` or `--prompt=MSG`: Set the prompt message.

- `-r` or `--rule=REGEX`: Use the Regular Expression `REGEX` to validate the input. This creates an infinite read loop until the input matches `REGEX`.

- `-e` or `--error=MSG`: Set the error message. `MSG` is a [`printf`](https://fishshell.com/docs/2.3/commands.html#printf) builtin format string. Use the first positional %s to display the read input.

- `-s` or `--silent[=NUMBER]`: Hide the user input as it is being typed. Use this option to handle passwords or other sensitive data. Optionally, indicate a `NUMBER` to read up to a certain number of characters instead of a new line by default.

- `-d` or `--default=STRING`: Use default value if none selected.

- `-q` or `--quiet`: Suppress standard output.

- `--no-case`: Ignore case during validation.

- `--no-cursor`: Hide cursor.

- `-h` or `--help`: Show usage help.

## Usage

`get` will print any user input to standard output by default.

```fish
get
```

Use `--prompt=MSG` to display a prompt.

```fish
get --prompt "What's your name?\n-> "
```

Use `--rule=REGEX` to validate the user input.

```fish
get --prompt="Enter a number:" --rule="[0-9]"
```

Use `--error=MSG` to display an error message when `--rule=REGEX` fails. The error message can be [`printf`](https://fishshell.com/docs/2.3/commands.html#printf) builtin format string and the user input can be displayed using `%s`.

```fish
get --prompt="Enter a number:" --rule="[0-9]" --error="'%s' is not a valid number."
```

Use `--silent` to hide the user input and read a password into a variable.

```fish
get --prompt="Enter your password:" --silent
```

Using `--silent` in combination with `--rule` and `--error` will hide the input from the error message using a star character `*`.

```fish
get --prompt="Enter your password:" --rule="[0-9]" --error="Invalid password '%s'" --silent
```

Use `--no-cursor` to hide the cursor and `--silent=NUMBER` to read up to `NUMBER` of characters too.

> Use `--quiet` to suppress writing the read input to standard output.

```fish
get --prompt="Press any key to continue..." --no-cursor --silent=1
```

## License

Anyone is free to copy, modify, publish, use, compile, sell, or distribute this software, either in source code form or as a compiled binary, for any purpose, commercial or non-commercial, and by any means.

In jurisdictions that recognize copyright laws, the author or authors of this software dedicate any and all copyright interest in the software to the public domain. We make this dedication for the benefit of the public at large and to the detriment of our heirs and successors. We intend this dedication to be an overt act of relinquishment in perpetuity of all present and future rights to this software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
