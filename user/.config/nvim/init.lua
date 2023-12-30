vim.g.mapleader = ';'      -- defines <Leader>
vim.g.maplocalleader = ';' -- defines <LocalLeader>

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup('plugins')

vim.opt.number = true
vim.opt.mouse = ''
vim.opt.scrolloff = 5
vim.opt.clipboard:append('unnamedplus')
vim.opt.listchars = 'tab:> ,trail:.'
vim.opt.list = true
vim.opt.colorcolumn = '80,120'
vim.opt.wrap = false
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.keymap.set({'i', 'n'}, '<C-s>', '<ESC>:w<CR>')
vim.keymap.set({'n', 'v'}, '<Space>', '<C-f>')
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', 'x', '"_x')

vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('YankHighlight', {clear = true}),
    pattern = '*',
    callback = function() vim.highlight.on_yank() end,
})
