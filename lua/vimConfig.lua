-- standard
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

-- remap switch window
vim.cmd("noremap <C-h> <C-w>h")
vim.cmd("noremap <C-j> <C-w>j")
vim.cmd("noremap <C-k> <C-w>k")
vim.cmd("noremap <C-l> <C-w>l")


-- prevent usage of arrow keys
vim.cmd("noremap <Up> <Nop>")
vim.cmd("noremap <Down> <Nop>")
vim.cmd("noremap <Left> <Nop>")
vim.cmd("noremap <Right> <Nop>")

-- allow for copy paste from outside terminal
-- Check if we are in an SSH session
local is_ssh = os.getenv("SSH_CONNECTION") ~= nil or os.getenv("SSH_TTY") ~= nil

if is_ssh then
    vim.opt.clipboard = "unnamedplus"
    vim.g.clipboard = {
        name = 'osc52',
        copy = {
            ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
            ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
        },
        paste = {
            ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
            ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
        },
    }
else
    -- On your local machine, Ghostty will use your system's 
    -- native provider automatically if clipboard is set.
    vim.opt.clipboard = "unnamedplus"
end
