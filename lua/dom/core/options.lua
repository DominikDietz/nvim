-- Setting options
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.scrolloff = 8

-- Set highlight on search
vim.o.hlsearch = true
vim.o.incsearch = true

-- Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Tab
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching unless \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

vim.o.termguicolors = true

vim.o.splitright = true
