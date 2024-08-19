return {
  lazy = {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({ git = { enable = true, ignore = false }})
      require("nvim-web-devicons").setup()

      vim.keymap.set(
        "n",
        "<leader>e",
        require("nvim-tree.api").tree.toggle,
        {
          noremap = true,
          silent = true
        }
      )
    end
  }
}
