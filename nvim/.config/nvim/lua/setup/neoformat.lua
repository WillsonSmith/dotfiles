return {
  lazy = {
    "sbdchd/neoformat",
    config = function()
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("Formatters", {}),
        callback = function()
          vim.cmd("Neoformat")
        end
      })

      vim.g.neoformat_try_node_exe = 1
    end
  }
}
