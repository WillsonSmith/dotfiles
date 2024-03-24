local function formatSwift()
  local file = vim.api.nvim_buf_get_name(0)
  local cmd = string.format('swift-format %s', file)

  local formatted = vim.fn.system(cmd)
  if formatted then
    local lines = vim.split(formatted, '\n')
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  end
end

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
        -- manual swift formatting until sourcekit-lsp acknowledges formatting support
        if vim.bo.filetype == 'swift' then
          formatSwift()
          return
        end

        vim.lsp.buf.format {
          async = true,
          filter = function(client)
            if client.name == 'tsserver' or client.name == 'eslint' then
              return false
            end
            return true
          end
        }
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
        'astro',

        -- Linters
        'eslint',

        -- Formatters

        -- Misc
        'custom_elements_ls',
      }
    })

    ---@diagnostic disable-next-line: missing-fields
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
      ---@diagnostic disable-next-line: missing-fields
      window = {
        completions = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
        {
          { name = 'buffer' },
        }),
    })


    local function on_attach(client, bufnr)
      if not client then return end

      local navic = require('nvim-navic');
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end

      if client.name == 'tsserver' or client.name == "eslint" then
        -- disable tsserver and eslint formatting for now.
        -- we'll use prettier for formatting
        -- and eslint for linting
        -- change this so that it only disables formatting if prettier is installed
        return
      end

      if client.name == 'sourcekit' then
        vim.api.nvim_create_autocmd('BufWritePre', {
          callback = function()
            formatSwift()
          end
        })
        return
      end

      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd('BufWritePre', {
          callback = function()
            vim.lsp.buf.format({ async = false })
          end
        })
      end
    end

    local completionCapabilities = cmp_nvim_lsp.default_capabilities();

    lspconfig.sourcekit.setup({
      on_attach = on_attach,
      capabilities = completionCapabilities,
      cmd = { 'xcrun', 'sourcekit-lsp' }
    })

    lspconfig.tsserver.setup({
      on_attach = on_attach,
      capabilities = completionCapabilities,
      root_dir = lspconfig.util.root_pattern('package.json'),
      single_file_support = false,
    })

    lspconfig.denols.setup({
      on_attach = on_attach,
      capabilities = completionCapabilities,
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
      capabilities = completionCapabilities,
    })



    lspconfig.eslint.setup({
      on_attach = on_attach,
      capabilities = completionCapabilities,
    })

    local default_setup_servers = {
      'custom_elements_ls',
      'eslint',
      'rust_analyzer',
      'astro'
    }
    for _, lsp in ipairs(default_setup_servers) do
      lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = completionCapabilities,
      })
    end

    setup_lsp_keymaps();
  end
}


return lsp_config
