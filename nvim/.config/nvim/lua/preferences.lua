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
  cursorcolumn = true,
  -- colorcolumn = "79",
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()",
  foldenable = false,
}

for preference, value in pairs(preferences) do
  vim.opt[preference] = value
end

-- IDK why but Swift is ignoring global settings
-- Set tabs to 2 spaces
vim.api.nvim_create_augroup("SwiftFileType", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "SwiftFileType",
  pattern = "swift",
  callback = function()
    vim.bo.tabstop = 2      -- Set tabstop to 2 spaces
    vim.bo.shiftwidth = 2   -- Set shiftwidth to 2 spaces
    vim.bo.expandtab = true -- Use spaces instead of tabs
  end,
})

vim.api.nvim_create_augroup("MarkdownFileType", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "MarkdownFileType",
  pattern = "markdown",
  callback = function()
    vim.opt_local.spelllang = "en_us"
    vim.opt_local.spell = true
    -- vim.opt_local.textwidth = 80
  end
})
