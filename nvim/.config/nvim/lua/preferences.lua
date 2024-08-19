local preferences = {
  hlsearch = false,
  number = true,
  relativenumber = true,
  mouse = "a",
  clipboard = "unnamedplus",
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
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()",
  foldenable = false
}

for preference, value in pairs(preferences) do
  vim.opt[preference] = value
end
