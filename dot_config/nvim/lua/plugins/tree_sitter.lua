local tree_sitter_config = {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
    ts_update()
  end,
  config = function()
    require("nvim-treesitter.configs").setup {
    ensure_installed = {
      "javascript",
      "typescript",
      "tsx",
      "html",
      "css",
      "scss",
      "json",
      "yaml",
      "lua",
      "rust",
      "toml",
      "bash",
      "dockerfile",
      "regex",
    },
    highlight = {
      enabled = true
    },
    context_commentstring = {
      enable = true
    },
  }
  end,
  dependencies = {
    "joosepalviste/nvim-ts-context-commentstring",
  }
}

return tree_sitter_config
