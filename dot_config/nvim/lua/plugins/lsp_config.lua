local mod = {}

function mod.setup_keymaps()
  -- Global mappings
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

  -- Wait for the server to be ready before mapping the keybindings
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
      end, opts)
    end,
  })
end

local lsp_config = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "SmiteshP/nvim-navic",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    },
  config = function()
    require("neodev").setup({})
    local lspconfig = require("lspconfig")
    local navic = require("nvim-navic")

    local function on_attach(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    lspconfig.denols.setup {
      on_attach = on_attach,
      root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
      capabilities = capabilities,
    }

    lspconfig.tsserver.setup {
      on_attach = on_attach,
      root_dir = lspconfig.util.root_pattern("package.json"),
      single_file_support = false,
      capabilities = capabilities,
    }

    lspconfig.custom_elements_ls.setup{}

    lspconfig.lua_ls.setup {
      capabilities = capabilities,
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          }
        }
      }
    }

    local language_servers = { 'custom_elements_ls' }
    for _, lsp in ipairs(language_servers) do
      lspconfig[lsp].setup {
        capabilities = capabilities,
      }
    end

    mod.setup_keymaps()
  end
}

return lsp_config
