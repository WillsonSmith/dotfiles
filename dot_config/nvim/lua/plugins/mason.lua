local mason_config = {
  "williamboman/mason.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup {
      ensure_installed = {
        "custom_elements_ls",
        "denols",
        "eslint",
        "lua_ls",
        "rust_analyzer",
        "tsserver",
      }
    }
  end
}

return mason_config
