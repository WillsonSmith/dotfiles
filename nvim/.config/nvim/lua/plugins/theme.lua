vim.pack.add({
  "https://github.com/catppuccin/nvim",
})

require("catppuccin").setup {
  custom_highlights = function(colors)
    return {
      CmpBorder = { fg = colors.pink }
    }
  end
}

vim.cmd.colorscheme "catppuccin-frappe"
