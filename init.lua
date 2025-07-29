vim.g.mapleader = ' '         -- Leader key 
vim.opt.expandtab = true      -- Uses spaces instead of tabs 
vim.opt.tabstop = 2           -- Number of spaces a tab counts for 
vim.opt.softtabstop = 2       -- Number of spaces for editing tabs (e.g., when pressing <Tab>)
vim.opt.shiftwidth = 2        -- Number of spaces used for auto-indent (>> << etc.)
vim.opt.number = true         -- Shows absolute line numbers for all lines 
vim.opt.relativenumber = true -- Shows relative numbers except current line

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('onedark').setup {
        style = 'darker'
      }
      -- Enable theme
      require('onedark').load()
    end
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}
}

local opts = {}

require("lazy").setup(plugins, opts)

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"lua", "python", "rust"},
  highlight = { enable = true },
  indent = { enable = true }
})
