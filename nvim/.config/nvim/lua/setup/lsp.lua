local LSPFormatterAuGroup = vim.api.nvim_create_augroup("LSPFormatterGroup", {})
local INCLUDED_FORMATTERS = { --[[ "swift", ]] "lua" }
local lsp = {}

local function normalKeymap(keymaps, options)
  for _, keymap in pairs(keymaps) do
    local keystroke = keymap[1];
    local command = keymap[2];
    vim.keymap.set('n', keystroke, command, options or {});
  end
end

local function format(opts)
  local mergedOptions = vim.tbl_extend("force", { async = true }, opts or {})

  if (vim.tbl_contains(INCLUDED_FORMATTERS, vim.bo.filetype)) then
    vim.lsp.buf.format({
      async = mergedOptions.async,
      filter = function(client)
        return client.supports_method("textDocument/formatting")
      end
    })
  end
end

lsp.keymap = function()
  local globalKeymap = {
    { "<leader>d", vim.diagnostic.open_float },
    { "<leader>q", vim.diagnostic.setloclist },
    { "[d",        vim.diagnostic.goto_prev },
    { "]d",        vim.diagnostic.goto_next },
  }

  normalKeymap(globalKeymap);

  local onAttachKeymap = {
    { "gD",         vim.lsp.buf.declaration },
    { "gd",         vim.lsp.buf.definition },
    { "K",          vim.lsp.buf.hover },
    { "gi",         vim.lsp.buf.implementation },
    { "<C-k>",      vim.lsp.buf.signature_help },
    { "<leader>D",  vim.lsp.buf.type_definition },
    { "<leader>rn", vim.lsp.buf.rename },
    { "<leader>f",  format }
  }

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

      local options = { buffer = ev.buf }
      normalKeymap(onAttachKeymap, options)
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, options)
    end
  })
end

local autocompleteDependencies = {
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip"
}

local dependencies = {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "SmiteshP/nvim-navic",
  "folke/neodev.nvim",
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = autocompleteDependencies,
  },
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  { "hrsh7th/cmp-path",     lazy = true },
  { "hrsh7th/cmp-buffer",   lazy = true },
}

local requiredLanguageServer = {
  'tsserver',
  'lua_ls',
  'rust_analyzer',
  'astro',
  'eslint',
}

local function masonSetup()
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")

  mason.setup()
  mason_lspconfig.setup({ ensure_installed = requiredLanguageServer })
end

local function cmpSetup()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  cmp.setup({
    snippets = {
      expand = function(args)
        require("luasnip").lsp_expand(args)
      end
    },
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({
        select = true,
      }),
      ["<tab>"] = cmp.mapping(function(original)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          original()
        end
      end),
      ["<S-tab>"] = cmp.mapping(function(original)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.jump(-1)
        else
          original()
        end
      end)
    },
    window = {
      completions = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered()
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "path" },
      { name = "luasnip" },
    }
    )
  })
end

local function setupNavic(client, bufnr)
  local navic = require("nvim-navic")
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end


lsp.lazy = {
  "neovim/nvim-lspconfig",
  dependencies = dependencies,
  config = function()
    require("neodev").setup();
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local defaultCapabilities = cmp_nvim_lsp.default_capabilities()

    masonSetup()
    cmpSetup()

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = LSPFormatterAuGroup,
      callback = function() format({ async = false }) end
    })

    local defaultServers = { "tsserver", "lua_ls", "rust_analyzer", "astro" }
    for _, server in ipairs(defaultServers) do
      lspconfig[server].setup({
        on_attach = setupNavic,
        capabilities = defaultCapabilities
      })
    end

    lspconfig.sourcekit.setup {
      on_attach = setupNavic,
      capabilities = vim.tbl_deep_extend('force', defaultCapabilities, {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      }),
    }

    lsp.keymap()
  end
}

return lsp
