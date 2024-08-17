return {
  lazy = {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end,
    priority = 1000
  }
}
