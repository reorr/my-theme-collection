# fish-gitio

[![Build Status](https://img.shields.io/travis/jorgebucaran/fish-gitio.svg)](https://travis-ci.org/jorgebucaran/fish-gitio)
[![Releases](https://img.shields.io/github/release/jorgebucaran/fish-gitio.svg?label=latest)](https://github.com/jorgebucaran/fish-gitio/releases)

<a href=https://git.io title="GitHub URL Shortener">Git.io</a> CLI for the [fish shell](https://fishshell.com).

## Installation

Install with [Fisher](https://github.com/jorgebucaran/fisher) (recommended):

```
fisher add jorgebucaran/fish-gitio
```

<details>
<summary>Not using a package manager?</summary>

---

Copy [`gitio.fish`](gitio.fish) to any directory on your function path.

```fish
set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
curl https://git.io/gitio.fish --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/gitio.fish
```

To uninstall, remove the file.

</details>

### System Requirements

- [fish](https://github.com/fishshell) 2.0+
- [curl](https://github.com/curl/curl) [7.18.0](https://curl.haxx.se/changes.html#7_18_0)+

## Usage

You want to create a short URL for your GitHub profile, repositories, issues, release notes, tarballs, gists.

How do you do that? Here's how I did it for this repository.

```properties
gitio fish-gitio=https://github.com/jorgebucaran/fish-gitio
```

The `gitio` command takes a vanity code, followed by an equal sign, and a GitHub URL (see [supported hosts](#supported-hosts)).

```properties
gitio code=url
```

Don't need a vanity code? Just enter the URL and Git.io will generate a random code automatically. If the command exits successfully, your new URL will be displayed on the console.

Notice that once you've created a URL, there's no way to undo this. Your best bet is to contact GitHub Support and ask if they would remove it for you.

## Supported Hosts

- https://github.com
- https://gist.github.com
- https://codeload.github.com
- https://raw.githubusercontent.com
- https://gist.githubusercontent.com

## License

[MIT](LICENSE.md)
