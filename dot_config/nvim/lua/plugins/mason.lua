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
        "tsserver",
        "eslint",
        "denols",
        "custom_elements_ls",
        "rust_analyzer",
        "lua_ls"
      }
    }
  end
}

return mason_config
