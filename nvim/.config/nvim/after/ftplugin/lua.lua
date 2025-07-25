require("lazydev").setup {}

if vim.fn.executable("lua-language-server") == 1 then
  vim.lsp.start {
    name = "Lua Language Server",
    cmd = { "lua-language-server" }
  }
end
