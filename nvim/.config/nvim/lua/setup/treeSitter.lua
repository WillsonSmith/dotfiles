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

local function initSwiftInjections()
  --   vim.treesitter.query.set("swift", "injections", [[
  --   ;; Skip swift interpolation
  --   (multi_line_string_literal
  --     (interpolated_expression (_) @swift))
  --
  --     (class_declaration
  --         (class_body
  --           (_
  --             (_
  --               (
  --                 (comment) @type_hint
  --                 (#eq? @type_hint "// LANG:CSS")
  --                 (statements
  --                   (multi_line_string_literal
  --                     (multi_line_str_text) @injection.content
  --                     (#set! "injection.language" "css"))))))))
  --
  --     (class_declaration
  --         (class_body
  --           (_
  --             (_
  --               (
  --                 (comment) @type_hint
  --                 (#eq? @type_hint "// LANG:JS")
  --                 (statements
  --                   (multi_line_string_literal
  --                     (multi_line_str_text) @injection.content
  --                     (#set! "injection.language" "javascript"))))))))
  --
  --     (class_declaration
  --         (class_body
  --           (_
  --             (_
  --               (
  --                 (comment) @type_hint
  --                 (#eq? @type_hint "// LANG:HTML")
  --                 (statements
  --                   (multi_line_string_literal
  --                     (multi_line_str_text) @injection.content
  --                     (#set! "injection.language" "html"))))))))
  --
  --     (class_declaration
  --         (class_body
  --           (_
  --             (_
  --               (_
  --                 (comment) @type_hint
  --                 (#eq? @type_hint "// LANG:HTML")
  --                 (control_transfer_statement
  --                   (multi_line_string_literal
  --                     (multi_line_str_text) @injection.content
  --                     (#set! injection.combined)
  --                     (#set! "injection.language" "html"))))))))
  -- ]])
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
