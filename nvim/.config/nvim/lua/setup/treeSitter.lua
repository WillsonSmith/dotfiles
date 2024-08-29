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
}

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
    end
  }
}
