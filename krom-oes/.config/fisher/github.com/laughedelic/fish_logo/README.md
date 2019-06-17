# fish_logo

[![](https://img.shields.io/badge/license-MIT-blue.svg)](https://www.tldrlegal.com/l/mit)
[![](https://fisherman-wharf.herokuapp.com/badge.svg)](https://fisherman-wharf.herokuapp.com)

This plugin adds a function to print out the [fish-shell](http://fish.sh) ASCII-art logo. And it's customizable! See [Usage](#usage) and [Examples](#examples).

<div align="center">
  <img
    width="400"
    src="https://gist.githubusercontent.com/laughedelic/b7d5e572b0a35afd51fd40a2d9eef66b/raw/default-base16-colors.png"
  />
</div>


## Installation

* Using [Fisher](https://github.com/jorgebucaran/fisher):
  ```shell
  fisher add laughedelic/fish_logo
  ```

* Using [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish):
  ```shell
  omf install fish_logo
  ```


## Usage

* This plugin adds the `fish_logo` function with the following _positional_ arguments:

  | # | Argument       | Default  |
  |--:|:---------------|:--------:|
  | 1 | outer color    |  `red`   |
  | 2 | medium color   |  `f70`   |
  | 3 | inner color    | `yellow` |
  | 4 | "mouth" symbol |   `[`    |
  | 5 | eye symbol     |   `O`    |

* Colors are any valid arguments of the [`set_color`](http://fish.sh/docs/current/commands.html#set_color) command: named colors, 3 or 6 hex digits. Named colors are _autocompleted_.

* To "skip" an argument (e.g. use the default), just pass an empty one:

  ```fish
  fish_logo f00 '' ff0
  ```

* If you don't want colors, you can use

  ```fish
  fish_logo normal normal normal
  ```

* There are several variations of the logo with different symbols used for its "mouth" and eye. The defaults correspond to the logo on the fish-shell website. Another variation of the logo seen in the wild uses `L` and `@` symbols:

  ```fish
  fish_logo '' '' '' L @
  ```

  This really affects how the fish looks, so try to experiment with it yourself.

* You can add this logo to your [fish greeting](http://fish.sh/docs/current/index.html#greeting) with this function:

  ```fish
  function fish_greeting
      fish_logo
  end
  ```

  Just write it to `~/.config/fish/functions/fish_greeting.fish` and you will see it every time you start a new session.


## Examples

Note, that named colors will be interpreted by _your terminal_, so the overall look of the logo will "adapt" to your terminal color scheme.  

The orange color is not in the standard 8-colors palette, so the default for it is hardcoded, but anyway it should look well with different variations of red and yellow.

| Terminal |  Typeface  | Color Schemes |
|:--------:|:----------:|:-------------:|
| [iTerm2] | [mononoki] |   [base16]    |

| ![red-google]      | ![blue-londontube] | ![red-default]      |
|:-------------------|:-------------------|:--------------------|
| ![blue-harmonic16] | ![red-solarized-l] | ![red-solarized]    |
| ![red-monokai]     | ![blue-solarized]  | ![blue-solarized-l] |


## Credits

This work is based on the following findings:

- In the [fish-shell repo](https://github.com/fish-shell/fish-shell):
  + [`doc_src/ascii_fish.png`](https://github.com/fish-shell/fish-shell/blob/master/doc_src/ascii_fish.png)
  + [`doc_src/branding/`](https://github.com/fish-shell/fish-shell/tree/master/doc_src/branding) with the graphical logo made by [@stestagg](https://github.com/stestagg)
  + discussion in [#114](https://github.com/fish-shell/fish-shell/issues/114) and the [function](https://github.com/fish-shell/fish-shell/issues/114#issuecomment-24101750) by [@xfix](https://github.com/xfix)
- [gist](https://gist.github.com/siteshwar/5472791) by [@siteshwar](https://github.com/siteshwar) with a variation of the logo


[iTerm2]: http://iterm2.com/
[mononoki]: http://madmalik.github.io/mononoki/
[base16]: https://github.com/chriskempson/base16/

[red-bright]:      https://gist.githubusercontent.com/laughedelic/b7d5e572b0a35afd51fd40a2d9eef66b/raw/red-base16-bright.dark.png
[red-colors]:      https://gist.githubusercontent.com/laughedelic/b7d5e572b0a35afd51fd40a2d9eef66b/raw/red-base16-colors.dark.png
[red-flat]:        https://gist.githubusercontent.com/laughedelic/b7d5e572b0a35afd51fd40a2d9eef66b/raw/red-base16-flat.dark.png
[red-default]:     https://gist.githubusercontent.com/laughedelic/b7d5e572b0a35afd51fd40a2d9eef66b/raw/red-base16-default.dark.png
[red-monokai]:     https://gist.githubusercontent.com/laughedelic/b7d5e572b0a35afd51fd40a2d9eef66b/raw/red-base16-monokai.dark.png
[red-solarized]:   https://gist.githubusercontent.com/laughedelic/b7d5e572b0a35afd51fd40a2d9eef66b/raw/red-base16-solarized.dark.png
[red-google]:      https://gist.githubusercontent.com/laughedelic/b7d5e572b0a35afd51fd40a2d9eef66b/raw/red-base16-google.dark.png
[red-tomorrow]:    https://gist.githubusercontent.com/laughedelic/b7d5e572b0a35afd51fd40a2d9eef66b/raw/red-base16-tomorrow.dark.png
[red-solarized-l]: https://gist.githubusercontent.com/laughedelic/b7d5e572b0a35afd51fd40a2d9eef66b/raw/red-base16-solarized.light.png

[blue-3024]:        https://gist.githubusercontent.com/laughedelic/b7d5e572b0a35afd51fd40a2d9eef66b/raw/blue-base16-3024.dark.png
[blue-eighties]:    https://gist.githubusercontent.com/laughedelic/b7d5e572b0a35afd51fd40a2d9eef66b/raw/blue-base16-eighties.dark.png
[blue-harmonic16]:  https://gist.githubusercontent.com/laughedelic/b7d5e572b0a35afd51fd40a2d9eef66b/raw/blue-base16-harmonic16.dark.png
[blue-londontube]:  https://gist.githubusercontent.com/laughedelic/b7d5e572b0a35afd51fd40a2d9eef66b/raw/blue-base16-londontube.dark.png
[blue-solarized]:   https://gist.githubusercontent.com/laughedelic/b7d5e572b0a35afd51fd40a2d9eef66b/raw/blue-base16-solarized.dark.png
[blue-solarized-l]: https://gist.githubusercontent.com/laughedelic/b7d5e572b0a35afd51fd40a2d9eef66b/raw/blue-base16-solarized.light.png
