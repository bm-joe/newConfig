-- vim settings
-- note to self : DISABLE THE F1 KEY PLSS
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
-- style arguments: rounded, single, double, solid, none
vim.opt.winborder = "single"
-- leader key
vim.g.mapleader = " "

-- keybinds: "mode" "button" "action"
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
-- format doc
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)


-- packages w/nightly package manager

vim.pack.add({
	-- fleur colourscheme
	{ src = "https://github.com/aikhe/fleur.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	-- consider adding oil (seems to be a file explorer of sorts)
	{ src = "https://github.com/stevearc/oil.nvim" },
	-- consider adding mini.pick, but it seems to be a worse version of telescope
	-- add typst later

})

-- require plugins and stuff
require "oil".setup()

-- plugin keybinds
vim.keymap.set('n', '<leader>e', ':Oil<CR>')


-- enabling languages for lsp
vim.lsp.enable({ "lua_ls" })


vim.cmd("colorscheme retrobox")
