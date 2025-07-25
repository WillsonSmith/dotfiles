vim.pack.add {
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/hrsh7th/cmp-cmdline",
  "https://github.com/hrsh7th/nvim-cmp",
}

require("snippets").register_cmp_source()
local cmp = require("cmp")
cmp.setup {
  snippet = {
    expand = function(arg)
      vim.snippet.expand(arg.body)
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
  },
  window = {
    completions = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  sources = {
    { name = "snp" },
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  }
}
