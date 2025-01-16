vim.g.mapleader = ';'      -- defines <Leader>
vim.g.maplocalleader = ';' -- defines <LocalLeader>
vim.g.c_syntax_for_h = 1

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
vim.opt.clipboard:append('unnamedplus')
vim.opt.listchars = 'tab:> ,trail:.'
vim.opt.list = true
vim.opt.colorcolumn = '80,111'
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'

vim.keymap.set({'i', 'n'}, '<C-s>'  , '<ESC>:w<CR>', {desc = 'Save file'})
vim.keymap.set({'n', 'v'}, '<Space>', '<C-f>'      , {desc = 'Scroll page down'})
vim.keymap.set('t', '<ESC>'  , '<C-\\><C-n>', {desc = 'Escape terminal'})
vim.keymap.set('n', '<C-l>'  , '<C-w>l'     , {desc = 'Go right'})
vim.keymap.set('n', '<C-h>'  , '<C-w>h'     , {desc = 'Go left'})
vim.keymap.set('n', '<C-j>'  , '<C-w>j'     , {desc = 'Go down'})
vim.keymap.set('n', '<C-k>'  , '<C-w>k'     , {desc = 'Go up'})
vim.keymap.set('n', '<Right>', 'z<Right>'   , {desc = 'Window right'})
vim.keymap.set('n', '<Left>' , 'z<Left>'    , {desc = 'Window left'})
vim.keymap.set('n', '<Down>' , '<C-e>'      , {desc = 'Window down'})
vim.keymap.set('n', '<Up>'   , '<C-y>'      , {desc = 'Window up'})
vim.keymap.set('i', '<Down>' , '<C-o>gj'    , {desc = 'Go down'})
vim.keymap.set('i', '<Up>'   , '<C-o>gk'    , {desc = 'Go up'})
vim.keymap.set('n', 'x'      , '"_x'        , {desc = 'Delete'})
vim.keymap.set('n', '<C-CR>' , '<C-]>'      , {desc = 'Follow link'})

vim.keymap.set('n', '<F5>', ':match Search /<C-R><C-W>/<CR>' , {desc = 'Match under cursor'})
vim.keymap.set('n', '<F4>', ':match None<CR>'                , {desc = 'Unmatch'})

vim.keymap.set('n', '<leader>ab',
    ':!bibtex-tidy %:p --blank-lines --duplicates --trailing-commas --no-wrap --sort-fields',
    {desc = 'Align bibtex'}
)
vim.keymap.set('n', '<leader>fxml', ':%!xmllint --format -', {desc = 'Format XML'})
-- vim.keymap.set('n', '<F6>', ':set wrap<CR>:set columns=117<CR>', {desc = 'Start writting mode'})
-- 117 = 80(text) + 30(neotree) + 1(NTsep) + 2(&signcolumn) + 4(&numberwidth)
vim.keymap.set('n', '<F6>', ':set wrap<CR>:vert 86 split<CR><C-w>l:enew<CR><C-w>h', {desc = 'Start writting mode'})
-- 86 = 80 + 2 + 4

vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('YankHighlight', {clear = true}),
    pattern = '*',
    callback = function() vim.highlight.on_yank() end,
})
