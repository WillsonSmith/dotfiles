return {
  lazy = {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      vim.cmd.colorscheme "catppuccin-frappe"
      require('catppuccin').setup({
        custom_highlights = function(colors)
          return {
            CmpBorder = { fg = colors.pink }
          }
        end
      })
    end,
    priority = 1000
  }
}
