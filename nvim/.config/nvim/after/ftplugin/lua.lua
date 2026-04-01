if vim.fn.executable("lua-language-server") == 1 then
  vim.lsp.start {
    name = "Lua Language Server",
    cmd = { "lua-language-server" },
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" }
        },
        workspace = {
          library = {
            vim.env.VIMRUNTIME
          }
        }
      }
    }
  }
end
