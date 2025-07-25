require("plugins.theme")
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.lualine")
require("plugins.oil")
require("plugins.cmp")
require("plugins.neoformat")

vim.pack.add {
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/airblade/vim-gitgutter",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/kylechui/nvim-surround",
  "https://github.com/numtoStr/Comment.nvim",
}

require("nvim-autopairs").setup {}
require("nvim-surround").setup {}
require("Comment").setup {}

vim.g.gitgutter_enabled = 1
