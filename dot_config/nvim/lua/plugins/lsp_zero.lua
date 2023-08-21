local lsp_zero_config = {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {'williamboman/mason.nvim'},           -- Optional
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},     -- Required
    {'hrsh7th/cmp-nvim-lsp'}, -- Required
    {'L3MON4D3/LuaSnip'},     -- Required

    -- Code context
    "SmiteshP/nvim-navic",
  },
  config = function()
    local lsp = require('lsp-zero').preset({})

    lsp.ensure_installed({
      "custom_elements_ls",
      "denols",
      "eslint",
      "lua_ls",
      "rust_analyzer",
      "tsserver",
    })

    local navic = require('nvim-navic')

    lsp.on_attach(function(client, bufnr)
      lsp.default_keymaps({buffer = bufnr})
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end)

    local lspconfig = require('lspconfig')

    lspconfig.lua_ls.setup(
      lsp.nvim_lua_ls({
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            diagnostics = {
              globals = { 'love' },
            },
          }
        }
      })
    )


    lspconfig.denols.setup({
      root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
    })

    lspconfig.tsserver.setup({
      root_dir = lspconfig.util.root_pattern("tsconfig.json"),
      single_file_support = false,
    })
    lsp.setup();
  end
}

return lsp_zero_config
