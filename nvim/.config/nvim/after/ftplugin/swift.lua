if vim.fn.executable("sourcekit-lsp") == 1 then
  vim.lsp.start {
    name = "Sourcekit",
    cmd = { "sourcekit-lsp" },
    root_dir = vim.fs.dirname(vim.fs.find({ "Package.swift" }, { upward = true })[1])
  }
end
