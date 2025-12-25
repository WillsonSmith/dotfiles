vim.pack.add {
  "https://github.com/nvim-treesitter/nvim-treesitter"
}


require("nvim-treesitter.install").update({ with_sync = true })()

require("nvim-treesitter").setup({})

require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "json",
    "yaml",
    "toml",
    "dockerfile",
    "lua",
    "bash",
    "vim",
    "vimdoc",
    "swift",
    "markdown"
  },
  highlight = { enable = true }
}
