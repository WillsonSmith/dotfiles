local tree_sitter_config = {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
    ts_update()
  end,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "javascript",
        "typescript",
        "tsx",
        "html",
        "styled",
        "css",
        -- "scss",
        "json",
        "yaml",
        "lua",
        "rust",
        "toml",
        "bash",
        "dockerfile",
        "regex",
        "vim",
        "vimdoc"
      },
      highlight = {
        enable = true
      },
    }
  end,
}

return tree_sitter_config
