vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/SmiteshP/nvim-navic",
  "https://github.com/nvim-lualine/lualine.nvim"
})

require("lualine").setup {
  options = {
    theme = "catppuccin",
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '', right = '' },
  },
  winbar = { lualine_c = { "navic" } },
  sections = {
    lualine_c = {
      "filename",
      function()
        local bufnr = vim.api.nvim_get_current_buf()
        local clients = vim.lsp.get_clients({
          bufnr = bufnr
        })

        if next(clients) == nil then
          return "(( no lsp ))"
        end

        local clientNames = {}
        for _, client in pairs(clients) do
          table.insert(clientNames, client.name)
        end

        return table.concat(clientNames, '|')
      end
    }
  }
}
