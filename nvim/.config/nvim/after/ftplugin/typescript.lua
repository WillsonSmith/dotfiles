if vim.fn.executable("tsgo") == 1 then
  vim.lsp.start {
    name = "Typescript (native)",
    cmd = { "tsgo", "--lsp", "--stdio" },
  }
else
  print("tsgo not found")
end

