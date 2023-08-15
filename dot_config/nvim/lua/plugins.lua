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


vim.g.mapleader = " "
-- Make sure to set `mapleader` before lazy so mappings are correct

require("lazy").setup({
  {
    "folke/neodev.nvim",
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      integrations = {
        cmp = true,
        nvimtree = true,
        treesitter = true,
      }
    }
  },

  "github/copilot.vim",
  "folke/which-key.nvim",
  "airblade/vim-gitgutter",
  "lukas-reineke/indent-blankline.nvim",

  require('plugins/lsp_config'),
  require('plugins/mason');
  require('plugins/null_ls'),
  require('plugins/tree_sitter'),
  require('plugins/lualine'),
  require('plugins/cmp'),
  require('plugins/dashboard'),
  require('plugins/telescope'),
  require('plugins/tree'),

  {
    "numtostr/comment.nvim",
    opts = {},
    lazy = false
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts= {}
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      use_diagnostic_signs = true
    },
  },

  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true
  },
})
