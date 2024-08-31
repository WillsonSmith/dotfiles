local IGNORED_FORMATTERS = {"swift"}

return {
  lazy = {
    "sbdchd/neoformat",
    config = function()
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("Formatters", {}),
        callback = function()
          if (not vim.tbl_contains(IGNORED_FORMATTERS, vim.bo.filetype)) then
            vim.cmd("Neoformat")
          end
        end
      })

      vim.g.neoformat_try_node_exe = 1
    end
  }
}
