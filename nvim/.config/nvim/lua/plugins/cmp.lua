vim.pack.add {
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/hrsh7th/cmp-cmdline",
  "https://github.com/hrsh7th/nvim-cmp",
}
local cmp = require("cmp")
cmp.setup {
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
    -- ["<tab>"] = cmp.mapping(function(original)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif luasnip.expand_or_jumpable() then
    --     luasnip.expand_or_jump()
    --   else
    --     original()
    --   end
    -- end),
    -- ["<S-tab>"] = cmp.mapping(function(original)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif luasnip.expand_or_jumpable() then
    --     luasnip.jump(-1)
    --   else
    --     original()
    --   end
    -- end)
  },
  window = {
    completions = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  }
}
