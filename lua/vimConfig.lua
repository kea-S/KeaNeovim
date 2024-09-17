vim.cmd("set expandtab") vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set autoindent")
vim.cmd("set smartindent")
vim.cmd("set wrap")
vim.cmd("set linebreak")
vim.cmd("set t_RV=")
vim.cmd("set t_u7=")
vim.cmd("set number relativenumber")
vim.cmd("set splitbelow")
vim.cmd("set splitright")

vim.g.maplocalleader = "\\"
vim.g.mapleader = " "

vim.cmd("noremap <Up> <Nop>")
vim.cmd("noremap <Down> <Nop>")
vim.cmd("noremap <Left> <Nop>")
vim.cmd("noremap <Right> <Nop>")
vim.api.nvim_set_keymap('n', '<C-h>', ':nohlsearch<CR>', { noremap = true, silent = true })
vim.opt.clipboard = "unnamedplus"
