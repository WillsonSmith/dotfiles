local tree_config = {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      git = {
        enable = true,
        ignore = false
      }
    })
    require 'nvim-web-devicons'.setup()

    local api = require "nvim-tree.api"
    vim.keymap.set('n', '<leader>e', api.tree.toggle, { noremap = true, silent = true })
  end
}

return tree_config
