local preferences = {
  hlsearch = false,
  number = true,
  relativenumber = true,
  mouse = "a",
  breakindent = true,
  undofile = true,
  backupdir = "/tmp/nvim/backup",
  ignorecase = true,
  smartcase = true,
  signcolumn = "yes",
  updatetime = 100,
  timeoutlen = 300,
  completeopt = "menuone,noselect",
  termguicolors = true,
  showmatch = true,
  incsearch = true,
  softtabstop = 2,
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  smartindent = true,
  cursorline = true,
  cursorcolumn = true,
  colorcolumn = "80",
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()",
  foldenable = false,
}

vim.g.mapleader = " "
for preference, value in pairs(preferences) do
  vim.opt[preference] = value
end

-- Globals
vim.g.gitgutter_enabled = 1

-- Global keymaps
-- copy to clipboard
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+yg_")
vim.keymap.set("n", "<leader>y", "\"+y")

-- paste from clipboard
vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>P", "\"+p")
vim.keymap.set("v", "<leader>p", "\"+p")
vim.keymap.set("v", "<leader>P", "\"+p")
