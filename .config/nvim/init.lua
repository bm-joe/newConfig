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

-- neovide copy and pasting
if vim.g.neovide then
  local function save() vim.cmd.write() end
  local function copy() vim.cmd([[normal! "+y]]) end
  local function paste() vim.api.nvim_paste(vim.fn.getreg("+"), true, -1) end

  vim.keymap.set({ "n", "i", "v" }, "<C-s>", save, { desc = "Save" })
  vim.keymap.set("v", "<C-c>", copy, { silent = true, desc = "Copy" })
  vim.keymap.set({ "n", "i", "v", "c", "t" }, "<C-v>", paste, { silent = true, desc = "Paste" })
end

--setting fontsize for neovide
vim.o.guifont = "JetBrainsMono Nerd Font Mono:h20"
vim.g.neovide_scale_factor = 1.0

-- autopen commands from a random blog
-- Open binary files
-- pdf
vim.api.nvim_create_autocmd("BufReadCmd", {
	pattern = "*.pdf",
	callback = function()
		local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
		vim.cmd("silent !firefox " .. filename .. " &")
		vim.cmd("let tobedeleted = bufnr('%') | b# | exe \"bd! \" . tobedeleted")
	end
})

-- images
vim.api.nvim_create_autocmd("BufReadCmd", {
	pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
	callback = function()
		local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
		vim.cmd("silent !firefox " .. filename .. " &")
		vim.cmd("let tobedeleted = bufnr('%') | b# | exe \"bd! \" . tobedeleted")
	end
})

-- vibecoded:
vim.api.nvim_create_user_command("Trm", function()
	local file_dir = vim.fn.expand("%:p:h")
	vim.fn.jobstart({ "kitty", "--working-directory", file_dir }, { detach = true })
end, {})

-- packages w/nightly package manager

vim.pack.add({
	{ src = "https://github.com/nyoom-engineering/oxocarbon.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/Myriad-Dreamin/tinymist" },
	-- consider adding oil (seems to be a file explorer of sorts)
	{ src = "https://github.com/stevearc/oil.nvim" },
	-- consider adding mini.pick, but it seems to be a worse version of telescope
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{src = "https://github.com/nvim-treesitter/nvim-treesitter"},

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
				'~/.config/sway',
				'~/.config/neovide',
				'~/.config/kitty',
				'~/.zshrc'
			}
		})
	end)

-- enabling languages for lsp
vim.lsp.enable({  "tinymist", "lua_ls" })
-- fix vim errors
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			}
		}
	}
}
)


vim.cmd("colorscheme oxocarbon")
