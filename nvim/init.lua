require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig'
	use 'navarasu/onedark.nvim'
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			-- Completion sources
			'hrsh7th/cmp-nvim-lsp',     -- LSP completions
			'hrsh7th/cmp-buffer',       -- Buffer completions
			'hrsh7th/cmp-path',         -- Path completions
			'hrsh7th/cmp-cmdline',      -- Command line completions
    			-- Snippet engine (required for nvim-cmp)
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
    
			-- Optional: snippet collection
			'rafamadriz/friendly-snippets',
		},
		config = function()
			require('config.completion')
		end
	}
end)

require("onedark").setup {
	style = "warmer"
}

require("onedark").load()

require("core.lsp")
