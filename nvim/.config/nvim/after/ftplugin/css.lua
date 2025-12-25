if vim.fn.executable("vscode-css-language-server") == 1 then
  vim.lsp.start {
    name = "css_ls",
    cmd = { "vscode-css-language-server", "--stdio" },
  }
else
  print("vscode-css-language-server not found")
end
