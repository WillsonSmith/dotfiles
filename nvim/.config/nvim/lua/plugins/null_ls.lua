local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local null_ls_config = {
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
      sources = {
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "javascript", "typescript", "json", "yaml", "markdown" }

          -- This doesn't work with monorepos
          -- condition = function(utils)
          --   return utils.has_file(".prettierrc.json", ".prettierrc", ".prettierrc.js", "prettier.config.js")
          -- end
        }),
        null_ls.builtins.diagnostics.stylelint.with({
          extra_filetypes = { "typescript" },
          condition = function(utils)
            return utils.root_has_file(
              ".stylelintrc",
              ".stylelintrc.json",
              ".stylelintrc.js"
            )
          end
        }),
      },
    })
  end
}

return null_ls_config
