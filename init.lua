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
				ensure_installed = { "lua" },

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
	}

})


vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

local telescopeBuiltin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", telescopeBuiltin.find_files, {})
vim.keymap.set("n", "<C-p>", telescopeBuiltin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
	telescopeBuiltin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])


vim.cmd [[colorscheme dracula]]
