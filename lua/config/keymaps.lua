-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

--map("n", "<Leader>,", ":Neotree action=show source=filesystem toggle=true<cr>", { noremap = true, silent = true, desc = "Open file browser" })
map("n", "<Leader>lg", function() Snacks.lazygit.open() end, { desc = "Open LazyGit"})
--map("n", "<Leader>n", ":Neotree reveal_force_cwd<cr>", { noremap = true, silent = true, desc = "Reveal current file in file browser" })
map("n", "<Leader>t", ":FzfLua git_files<cr>", { noremap = true, silent = true, desc = "Fzf with git files" })
map("n", "<Leader>f", ":FzfLua files<cr>", { noremap = true, silent = true, desc = "Fzf all files" })

-- ` to go to the next buffer; ~ to go back
map("n", "`", "<C-W>w", { silent = true, desc = "Next buffer" })
map("n", "<Bslash>", "<C-W>w", { desc = "Next buffer" })
map("n", "~", "<C-W>p", { silent = true, desc = "Previous buffer" })

-- Restore the original "." to repeat the last command
map("n", ".", ".", { silent = true, desc = "Repeat last command" })

-- Clear search highlights
map("n", "<CR>", ":noh<CR><CR>", { silent = true, desc = "Clear search highlights" })

-- Disable the flash plugin's hijacking of a very core vim command
-- vim.keymap.del("n", "s")

local function select_colorscheme()
	local schemes = vim.fn.getcompletion("", "color")

	vim.ui.select(schemes, { prompt = "Select a colorscheme:" }, function(choice)
		if choice then
			pcall(vim.cmd.colorscheme, choice)
			print("Colorscheme set to: " .. choice)
		else
			print("No colorscheme selected.")
		end
	end)
end

-- Map this function to a keybinding
vim.keymap.set("n", "<leader>cs", select_colorscheme, { noremap = true, silent = true })
