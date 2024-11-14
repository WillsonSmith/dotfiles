local required = {
  "javascript",
  "typescript",
  "tsx",
  "html",
  "css",
  "json",
  "yaml",
  "lua",
  "rust",
  "toml",
  "bash",
  "dockerfile",
  "regex",
  "vim",
  "vimdoc",
  "swift",
  "markdown",
}

-- Complex highlighting for nested interpolation of `\(varname)`

-- ;; Match a Swift multi-line string with interpolation and inject JavaScript for non-interpolated parts
--
-- ;; Capture interpolations and mark them as Swift
-- (multi_line_string_literal
--   (interpolation
--     (_) @swift))
--
-- ;; Inject JavaScript for the non-interpolated parts
-- (multi_line_string_literal
--   (multi_line_str_text) @javascript
--   ;; Avoid matching interpolation within the string
--   (#not-any-of? @javascript "\\"))
--
-- (language-injection @javascript "javascript")


-- Regular–ass highlighting

-- vim.treesitter.query.set("swift", "injections", [[
-- (call_expression
--   (simple_identifier) @lang_id
--   (#eq? @lang_id "javascript") ;; Adjust for the identifier you're using
--   (call_suffix
--     (lambda_literal
--       (statements
--         (multi_line_string_literal
--           (multi_line_str_text) @injection.content
--           (#set! injection.language "javascript"))))))
-- ]])

local function initSwiftInjections()
  -- These injections appear and then disappear due to LSP Sematnic Highlighting
  -- Will have to either disable it or figure out something else

  vim.treesitter.query.set("swift", "injections", [[
  (multi_line_string_literal
    (interpolated_expression
      (_) @swift))

    (property_declaration
    name: (pattern
          bound_identifier: (simple_identifier) @lang_id
          (#eq? @lang_id "css"))
    computed_value: (computed_property
                    (statements
                      (multi_line_string_literal
                        (multi_line_str_text) @injection.content)
                      (#set! "priority" 120)
                      (#set! "injection.language" "css")
                      )))

(property_declaration
    name: (pattern
          bound_identifier: (simple_identifier) @lang_id
          (#eq? @lang_id "javascript"))
    computed_value: (computed_property
                    (statements
                      (multi_line_string_literal
                        (multi_line_str_text) @injection.content)
                      (#set! "priority" 120)
                      (#set! "injection.language" "javascript")
                      )))




]])
  -- (property_declaration
  --   name: (pattern
  --           (simple_identifier) @lang_id
  --           (#eq? @lang_id "javascript"))
  --   computed_value: (computed_property
  --                     (statements
  --                       (multi_line_string_literal
  --                         (multi_line_str_text) @injection.content)
  --                       (#set! "injection.language" "javascript"))))
end

return {
  lazy = {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      local install = require("nvim-treesitter.install")
      install.update({ with_sync = true })()
    end,
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = required,
        highlight = { enable = true }
      })

      initSwiftInjections()
    end
  }
}
