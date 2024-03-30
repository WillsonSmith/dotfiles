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

-- `mapleader` must be set before `lazy` is called
vim.g.mapleader = " "

-- local cslsp = require('plugins/custom_lsp/server')
-- vim.api.nvim_create_autocmd(
--   { "BufRead" },
--   {
--     group = vim.api.nvim_create_augroup('custom_lsp', {}),
--     pattern = { "*.fish" },
--     callback = function()
--       print("Fish file opened")
--       -- vim.lsp.buf.formatting_sync()
--       --
--       vim.lsp.start({
--         name = 'dumdum',
--         cmd = cslsp.server({
--           capabilities = {
--             textDocument = {
--               formatting = true,
--             }
--           },
--           handlers = {
--             ['textDocument/formatting'] = function(_, params)
--               return {
--                 {
--                   range = {
--                     start = { line = 0, character = 0 },
--                     ['end'] = { line = 1, character = 0 },
--                   },
--                   newText = 'formatted'
--                 }
--               }
--             end
--           }
--         })
--       })
--     end
--   }
-- )
require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      custom_highlights = function(colors)
        -- Correct for indent whitespace dot characters
        return {
          NonText = { fg = colors.color0 },
          Whitespace = { fg = colors.color0 },
        }
      end,
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

  require('plugins/indent_blankline'),
  require('plugins/null_ls'),
  require('plugins/lsp'),
  require('plugins/lualine'),
  require('plugins/telescope'),
  require('plugins/toggle_terminal'),
  require('plugins/tree'),

  require('plugins/tree_sitter'),
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = {
    },
    config = function()
      require('ts_context_commentstring').setup({
        enable_autocmd = false,
        languages = {
          styled = '/* %s */'
        }
      })
    end
  },
  {
    "numtoStr/Comment.nvim",
    opts = {
    },
    config = function()
      require('Comment').setup({
        pre_hook = require(
          'ts_context_commentstring.integrations.comment_nvim'
        ).create_pre_hook()
      })
    end,
    lazy = false
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {}
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      use_diagnostic_signs = true
    },
  },
})
