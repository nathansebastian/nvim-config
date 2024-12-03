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

require('lazy').setup({
	-- Color scheme
	{
		"catppuccin/nvim", 
		name = "catppuccin", 
		priority = 1000,
	},

	-- Fuzzy Finder
	{ 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

	-- Treesitter
	{'nvim-treesitter/nvim-treesitter'},
	{'nvim-treesitter/playground'},	

    {'habamax/vim-godot', event = 'VimEnter'},

	-- File Tree
	{"nvim-tree/nvim-tree.lua", version ="*", lazy = false, dependencies = {"nvim-tree/nvim-web-devicons",}, },
	-- Undo Tree
	{'mbbill/undotree'},
	-- Dev Icons
	{'nvim-tree/nvim-web-devicons'},
	-- Git Stuff
	-- {'tpope/vim-fugitive'},
	-- Visualise buffers as tabs
	{'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},


	-- Comments
	{'terrortylor/nvim-comment'},

	-- LSP
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},

    -- Discord Presence
    {'vyfor/cord.nvim',build ='./build || .\\build',event = 'VeryLazy',opts = {} },

    -- LuaSnip
    -- {"L3MON4D3/LuaSnip",},

    -- Debugger
    -- {'mfussenegger/nvim-dap'},
    -- {'rcarriga/nvim-dap-ui'},
    -- {'nvim-neotest/nvim-nio'},
    -- {'williamboman/mason.nvim'},
    -- {'jay-babu/mason-nvim-dap.nvim'},
})
