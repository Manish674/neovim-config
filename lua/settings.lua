local o=vim.o
local bo=vim.bo
local wo=vim.wo

o.syntax = 'on'
o.errorbells = false
o.smartcase = true
o.showmode = false
o.backup = false
o.termguicolors = true
o.undodir = vim.fn.stdpath('config') .. '/undodir'
o.undofile = true
o.incsearch = true
o.cursorline = true
o.cursorlineopts = line
o.hidden = true
o.completeopt='menuone,noinsert,noselect'
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.scrolloff = 5

bo.swapfile = false
bo.autoindent = true
bo.smartindent = true

wo.signcolumn = 'no'
wo.wrap = false

vim.g.mapleader = ' '
vim.g.colorscheme = "default"

options = { noremap = true }
vim.api.nvim_set_keymap('n', '<leader>e', ':Lexplore<cr>', options)



