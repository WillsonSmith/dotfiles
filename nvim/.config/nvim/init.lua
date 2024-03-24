-- Disable built-in file explorer
-- Do this before loading plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("options")
require("plugins")

vim.cmd.colorscheme "catppuccin"

vim.g.astro_typescript = 'enable'
vim.g.astro_styles = 'enable'

vim.filetype.plugin = 'on'

-- vim.cmd('autocmd! BufRead,BufNewFile *.leaf setfiletype html')
