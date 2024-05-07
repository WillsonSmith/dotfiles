local augroup = vim.api.nvim_create_augroup("NullLsLspFormatting", {})

local null_ls_config = {
  "nvimtools/none-ls.nvim",
  config = function()
    local scan = require 'plenary.scandir'
    local null_ls = require("null-ls")
    null_ls.setup({
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              print("formatting " .. client.name)
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
      sources = {
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "javascript", "typescript", "json", "yaml", "markdown" },
          condition = function(utils)
            if utils.root_has_file(".prettierrc", ".prettierrc.json", ".prettierrc.js", "prettier.config.js") then
              return true
            end

            local nested_prettier = scan.scan_dir(vim.fn.getcwd(), {
              search_pattern = ".prettierrc",
              hidden = true,
              depth = 4,
            })

            return #nested_prettier > 0
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
    })
  end
}

return null_ls_config
