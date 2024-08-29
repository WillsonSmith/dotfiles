require("setup.lazy").init();

require("lazy").setup({
  require("theming.setup").lazy,

  "nvim-lua/plenary.nvim",
  "airblade/vim-gitgutter",
  "virchau13/tree-sitter-astro",
  require("setup.autopairs").lazy,
  require("setup.surround").lazy,
  require("setup.trouble").lazy,
  require("setup.luasnip").lazy,
  require("setup.lsp").lazy,
  require("setup.toggleterm").lazy,
  require("setup.neoformat").lazy,
  require("setup.lualine").lazy,
  require("setup.tree").lazy,
  require("setup.treeSitter").lazy,
  require("setup.telescope").lazy,
  require("setup.contextCommentString").lazy,
  require("setup.comment").lazy
})
