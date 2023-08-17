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
      custom_highlights = function(colors)
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

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      vim.opt.termguicolors = true
      -- Sets the colors for the indent lines
      vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

      vim.opt.list = true
      vim.opt.listchars:append "space:·"

      require('indent_blankline').setup{
        space_char_blankline = " ",
        -- This plugin seems to overwrite the highlight group for the space character
        -- This is a workaround to unset the highlight group
        space_char_highlight_list = {"clear"},
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
          "IndentBlanklineIndent3",
          "IndentBlanklineIndent4",
          "IndentBlanklineIndent5",
          "IndentBlanklineIndent6",
        }
      }
    end
  },

  require('plugins/lsp_config'),
  require('plugins/mason');
  require('plugins/cmp'),
  require('plugins/null_ls'),
  require('plugins/tree_sitter'),
  require('plugins/lualine'),
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
    opts = {
      open_mapping = [[<c-\>]],
      insert_mappings = true
    },
    config = function()
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
        },
        -- function to run on opening the terminal
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
        -- function to run on closing the terminal
        on_close = function()
          vim.cmd("startinsert!")
        end,
      })

      local function lazygit_toggle()
        lazygit:toggle()
      end

      vim.keymap.set('n', '<leader>g', lazygit_toggle)
    end
  },
})
