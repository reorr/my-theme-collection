# fish-menu

Create interactive prompt menus with [fish shell](https://fishshell.com).

## Installation

With [Fisher](https://github.com/jorgebucaran/fisher)

```
fisher add fishpkg/fish-menu
```

## Usage

```console
menu 1 2 3

> 1
> 2
> 3
```

### Options

#### `menu_cursor_glyph`

Set cursor character.

> Default: `>`.

#### `menu_hover_item_style`

Set hover item style.

> Default: None.

#### `menu_multiple_choice`

Enable multiple choice mode.

> Default: `false`.

#### `menu_selected_item_style`

Set selected item style.

> Default: None.

#### `menu_checked_glyph`

Checked item glyph.

> Default: `[x]`

#### `menu_unchecked_glyph`

Unchecked item glyph.

Default: `[ ]`

#### `menu_selected_index`

Use menu_selected_index to retrieve the selected item index from \$argv.

### Example

```fish
set -l items "Batman" "Flash" "Superman" "Aquaman"

set -l menu_hover_item_style -o black -b yellow
set -l menu_cursor_glyph ▶
set -l menu_cursor_glyph_style -o

menu $items
```

## License

Anyone is free to copy, modify, publish, use, compile, sell, or distribute this software, either in source code form or as a compiled binary, for any purpose, commercial or non-commercial, and by any means.

In jurisdictions that recognize copyright laws, the author or authors of this software dedicate any and all copyright interest in the software to the public domain. We make this dedication for the benefit of the public at large and to the detriment of our heirs and successors. We intend this dedication to be an overt act of relinquishment in perpetuity of all present and future rights to this software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

