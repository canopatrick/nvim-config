Based on the [LazyVim starter kit](https://github.com/LazyVim/starter).

## Installation

```sh
test -d ~/.config/nvim && mv ~/.config/nvim ~/.config/nvim-orig
git clone https://github.com/canopatrick/nvim-config.git ~/.config/nvim
```

## Tips and Tricks

To disable a particular key mapping for a default plug-in, simply set it to `false` in the plug-in's `keys` settings:

```lua
return {
  "foo/plugin",
  keys = {
    { "<leader>f", false },
  }
}
```
