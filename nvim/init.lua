-- Bootstrap lazy.nvim
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

-- Set leader key
vim.g.mapleader = ","  -- Space as leader key

-- General indentation settings
vim.opt.tabstop = 4        -- Number of spaces a tab counts for
vim.opt.shiftwidth = 4     -- Number of spaces for each indentation level
vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true  -- Copy indent from current line

-- Setup plugins with Lazy
require("lazy").setup({
  -- LSP Configuration
  'neovim/nvim-lspconfig',
  
  -- Colorscheme
  'navarasu/onedark.nvim',
  
  -- Completion engine with all dependencies
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
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
  },
  
  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('config.nvim-tree')
    end
  },
  
  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true }
      })
    end
  },
  
  -- Telescope fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 
      'nvim-lua/plenary.nvim',
      -- Optional: for better performance
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      
      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = {"truncate"},
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
      })
      
      -- Load fzf extension if available
      pcall(telescope.load_extension, 'fzf')
      
      -- Key mappings
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent files' })
      vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Commands' })
    end
  }
})

-- Your existing theme configuration
require("onedark").setup {
  style = "warmer"
}
require("onedark").load()

-- Your existing LSP configuration
require("core.lsp")
