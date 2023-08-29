local setup_lsp_keymaps = function()
  vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      local options = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, options)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, options)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, options)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, options)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, options)
      vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, options)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, options)
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, options)
      vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format({ async = true })
      end, options)
    end
  })
end

local lsp_config = {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- Autocompletion
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
      }
    },

    -- Code context
    'SmiteshP/nvim-navic',

    -- Language-specific
    "folke/neodev.nvim",
  },
  config = function()
    require('neodev').setup({})

    local lspconfig = require('lspconfig');
    local cmp = require('cmp');
    local cmp_nvim_lsp = require('cmp_nvim_lsp');
    local mason = require('mason');
    local mason_lspconfig = require('mason-lspconfig');


    mason.setup();
    mason_lspconfig.setup({
      ensure_installed = {
        -- Languages
        'tsserver',
        'denols',
        'lua_ls',
        'rust_analyzer',

        -- Linters
        'eslint',

        -- Formatters

        -- Misc
        'custom_elements_ls',
      }
    })

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end
      },
      mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
          select = true,
        })
      },
      window = {
        completions = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
        {
          { name = 'buffer ' },
        }),
    })

    local navic = require('nvim-navic');
    local function on_attach(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end

      if
          client.server_capabilities.documentFormattingProvider
          and client.supports_method("textDocument/formatting")
      then
        vim.api.nvim_create_autocmd('BufWritePre', {
          callback = function()
            vim.lsp.buf.format({ async = false })
          end
        })
      end
    end

    local cmp_capabilities = cmp_nvim_lsp.default_capabilities();

    lspconfig.tsserver.setup({
      on_attach = on_attach,
      capabilities = cmp_capabilities,
      root_dir = lspconfig.util.root_pattern('package.json'),
      single_file_support = false,
    })

    lspconfig.denols.setup({
      on_attach = on_attach,
      capabilities = cmp_capabilities,
      root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc')
    })

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
          diagnostics = {
            globals = { 'love' }
          }
        },
      },
      on_attach = on_attach,
      capabilities = cmp_capabilities,
    })

    local default_setup_servers = {
      -- 'custom_elements_ls',
      'eslint',
      'rust_analyzer',
    }

    for _, lsp in ipairs(default_setup_servers) do
      lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = cmp_capabilities,
      })
    end

    setup_lsp_keymaps();
  end
}

return lsp_config
