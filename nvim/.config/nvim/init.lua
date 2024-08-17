-- Disable built-in file explorer
-- Do this before loading plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("options")
require("plugins")

vim.g.astro_typescript = 'enable'
vim.g.astro_styles = 'enable'
vim.filetype.plugin = 'on'
vim.g.skip_ts_context_commentstring_module = true
vim.g.neoformat_try_node_exe = 1
