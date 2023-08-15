local tree_config = {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional
  },
  config = function()
    require("nvim-tree").setup()
    require'nvim-web-devicons'.setup()
  end
}

return tree_config
