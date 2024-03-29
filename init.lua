vim.cmd [[lua print("Hello Michael! 😀")]]


vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.o.guicursor = 'a:blinkwait300-blinkon200-blinkoff150' 


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
    	"clone",
    	"--filter=blob:none",
    	"https://github.com/folke/lazy.nvim.git",
    	"--branch=stable",
    	lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local modulesToDisable = { "c", "vim", "vimdoc", "query" }

require("lazy").setup({

	{
		"Mofiqul/dracula.nvim",
		lazy = true
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function ()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = { "lua", "typescript", "c_sharp", "javascript", "json" },

				sync_install  = false,
				auto_install = false,

				highlight = {
					enable = true,
					disable = modulesToDisable
				},
				
				indent = { 
					enable = true,
					disable = modulesToDisable
				}
			})
		end
	},

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" }
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }
	}

})

require("lualine").setup({
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "filename" },
		lualine_c = {},
		lualine_x = {},
		lualine_y = { "progress" },
		lualine_z = { "location" }
	}
})


vim.g.mapleader = " "

vim.keymap.set("n", "<leader>d", vim.cmd.Ex)

local telescopeBuiltin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fw", function()
	telescopeBuiltin.grep_string({ search = "" })
end)

vim.keymap.set("n", "<leader>cfw", telescopeBuiltin.grep_string)
vim.keymap.set("n", "<leader>ff", telescopeBuiltin.git_files)

vim.keymap.set("n", "+",[[<cmd>vertical resize +5<cr>]])
vim.keymap.set("n", "-",[[<cmd>vertical resize -5<cr>]])

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>==gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>==gv")

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

vim.cmd [[colorscheme dracula]]
