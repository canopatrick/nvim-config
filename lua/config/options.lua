-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","
vim.colorscheme = "sonokai"
-- vim.g.lazyvim_picker = "fzf"
vim.g.lazyvim_picker = "auto"
-- vim.opt.shiftwidth =
vim.g.autoformat = true
-- vim.lsp.buf.format = {
--   formatting_options = nil,
--   timeout_ms = nil,
-- },
vim.g.fixendofline = true

-- Verbose editorconfig
vim.g.EditorConfig_verbose = 1


-- Pick up changes made outside of Neovim
vim.o.autoread = true
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  command = "checktime",
})
