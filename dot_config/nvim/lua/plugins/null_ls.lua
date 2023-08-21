local null_ls_config = {
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    -- Define autogroup to run formatting on save
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier.with({
          condition = function(utils)
            return utils.root_has_file(".prettierrc.json", ".prettierrc", ".prettierrc.js", "prettier.config.js")
          end
        }),
        null_ls.builtins.diagnostics.eslint.with({
          condition = function(utils)
            return utils.root_has_file(".eslintrc.js", ".eslintrc.json", ".eslintrc")
          end
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
        -- can reuse a shared lspconfig on_attach callback
        on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                  group = augroup,
                  buffer = bufnr,
                  callback = function()
                      vim.lsp.buf.format({async = false})
                  end,
                })
            end
        end,
    })
  end
}

return null_ls_config

