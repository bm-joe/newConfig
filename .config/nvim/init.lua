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
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/Myriad-Dreamin/tinymist" },
	-- consider adding oil (seems to be a file explorer of sorts)
	{ src = "https://github.com/stevearc/oil.nvim" },
	-- consider adding mini.pick, but it seems to be a worse version of telescope
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	-- add typst later

})

-- require plugins and stuff
require "oil".setup({
	-- oil config
	default_file_explorer = true,
	columns = {
		"icon",
		-- "permissions",
		-- "size",
		-- "mtime",
	},

	view_options = {
		-- showing hidden files :3
		show_hidden = true
	},

	prompt_save_on_select_new_entry = true,
})

-- require "plenary".setup()
require "telescope".setup()
require "typst-preview".setup({

	port = 0,
	host = '127.0.0.1',
	invert_colors = 'never',
	dependencies_bin = {
		['tinymist'] = nil,
		['websocat'] = nil,
	},
	extra_args = nil,

	-- -- This function will be called to determine the root of the typst project
	-- get_root = function(path_of_main_file)
	-- 	local root = os.getenv 'TYPST_ROOT'
	-- 	if root then
	-- 		return root
	-- 	end
	--
	-- 	-- Look for a project marker so imports from parent dirs stay inside root
	-- 	local main_dir = vim.fs.dirname(vim.fn.fnamemodify(path_of_main_file, ':p'))
	-- 	local found = vim.fs.find({ 'typst.toml', '.git' }, { path = main_dir, upward = true })
	-- 	if #found > 0 then
	-- 		return vim.fs.dirname(found[1])
	-- 	end
	--
	-- 	return main_dir
	-- end,
	--
	-- -- This function will be called to determine the main file of the typst
	-- -- project.
	-- get_main_file = function(path_of_buffer)
	-- 	return path_of_buffer
	-- end,
	--
	--

})

-- for executing functions and stuph
local builtin = require('telescope.builtin')

-- plugin keybinds
vim.keymap.set('n', '<leader>e', ':Oil<CR>')
vim.keymap.set('n', '<leader><Tab>', ':Telescope<CR>')
-- find files
vim.keymap.set('n', '<leader>s',
	function()
		builtin.find_files({
			search_dirs = {
				'~/G12',
				'~/Downloads',
				'~/.config/nvim',
				'~/.config/sway'
			}
		})
	end)

-- enabling languages for lsp
vim.lsp.enable({ "lua_ls", "tinymist" })


vim.cmd("colorscheme retrobox")
