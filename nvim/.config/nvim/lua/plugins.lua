require("setup.lazy").init();

require("lazy").setup({
  require("theming.setup").lazy,

  "nvim-lua/plenary.nvim",
  "airblade/vim-gitgutter",
  "virchau13/tree-sitter-astro",
  { "windwp/nvim-autopairs", event = "InsertEnter" },
  { "kylechui/nvim-surround", event = "VeryLazy" },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { use_diagnostic_signs = true }
  },
  require("setup.lsp").lazy,
  require("setup.neoformat").lazy,
  require("setup.lualine").lazy,
  require("setup.tree").lazy,
  require("setup.treeSitter").lazy,
  require("setup.telescope").lazy,
  require("setup.contextCommentString").lazy,
  require("setup.comment").lazy
})
