vim.pack.add {
  "https://github.com/sbdchd/neoformat"
}

local IGNORED_FORMATTERS = { --[[ "swift" ]] "xml" }

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("Formatters", {}),
  callback = function()
    if (not vim.tbl_contains(IGNORED_FORMATTERS, vim.bo.filetype)) then
      vim.cmd("Neoformat")
    end
  end
})

vim.g.neoformat_swift_swiftformat = {
  exe = "swiftformat",
  args = { "--config", ".swiftformat" },
  stdin = 1
}
