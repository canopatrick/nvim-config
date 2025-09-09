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

### nvim-dap with vscode-jsdebug

You will need to download and install the [Microsoft vscode-js-debug package](https://github.com/microsoft/vscode-js-debug):

```sh
test -d ~/opensource || mkdir ~/opensource
cd ~/opensource
git clone https://github.com/microsoft/vscode-js-debug.git
cd vscode-js-debug
npm install --legacy-peer-deps --no-save && \
  npx gulp vsDebugServerBundle && \
  rm -rf out && \
  mv dist out
```

Now add a `VSCODE_JS_DEBUG_PATH` environment variable to your shell config. Example:

```sh
echo 'VSCODE_JS_DEBUG_PATH="${HOME}/opensource/vscode-js-debug"' >> ~/.zshrc
```
