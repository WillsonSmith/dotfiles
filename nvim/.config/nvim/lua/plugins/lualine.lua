local lualine_config = {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'neovim/nvim-lspconfig',
    'SmiteshP/nvim-navic',
  },
  config = function()
    require("lualine").setup({
      options = {
        theme = "catppuccin",
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'NvimTree' }
      },
      winbar = {
        lualine_c = { 'navic' }
      },
      sections = {
        lualine_c = {
          'filename',
          function()
            local msg = '(no lsp client)'
            local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
            local clients = vim.lsp.get_active_clients()
            if next(clients) == nil then return msg end
            for _, client in ipairs(clients) do
              local filetypes = client.config.filetypes
              if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
              end
            end
            return msg
          end
        },
        lualine_x = {
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = "#ff9e64" },
          },
        },
      },
    })
  end
}

return lualine_config
