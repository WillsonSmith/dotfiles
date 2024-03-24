local opt = vim.opt

-- Don't highlight search results
opt.hlsearch = false

-- Enable line numbers
opt.number = true
opt.relativenumber = true

-- Enable mouse mode
opt.mouse = "a"

opt.clipboard = "unnamedplus"

opt.breakindent = true

-- Undo history will persist through sessions
opt.undofile = true
opt.backupdir = "/tmp/nvim/backup"

-- Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true

opt.signcolumn = "yes"

-- Decrease update time
opt.updatetime = 100
opt.timeoutlen = 300

opt.completeopt = "menuone,noselect"

opt.termguicolors = true

opt.showmatch = true
opt.incsearch = true

-- Tab settings
opt.softtabstop = 2
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- Highlight current line
opt.cursorline = true

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
