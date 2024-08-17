local dependencies = {
  "nvim-tree/nvim-web-devicons",
  "neovim/nvim-lspconfig",
  "SmiteshP/nvim-navic",
}

local sectionC = {
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

local lazyStatus = require("lazy.status");
local sectionX = {
  {
    lazyStatus.updates,
    cond = lazyStatus.has_updates,
    color = { fg = "#ff9e64" }
  }
}

local function configure()
  local options = {
    theme = "catppuccin",
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'NvimTree' }
  }

  require("lualine").setup({
    options = options;
    winbar = { lualine_c = { "navic" } },
    sections = {
      lualine_c = sectionC,
      lualine_x = sectionX
    }
  })
end

return {
  lazy = {
    "nvim-lualine/lualine.nvim",
    dependencies = dependencies,
    config = configure
  }
}
