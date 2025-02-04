-- http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
return {
    'godlygeek/tabular',
    config = function()
        vim.keymap.set({'n', 'v'}, '<leader>a=', ':Tabularize /=<CR>'     , {desc = 'Align at ='})
        vim.keymap.set({'n', 'v'}, '<leader>a|', ':Tabularize /|<CR>'     , {desc = 'Align at |'})
        vim.keymap.set({'n', 'v'}, '<leader>a&', ':Tabularize /&<CR>'     , {desc = 'Align at &'})
        vim.keymap.set({'n', 'v'}, '<leader>a:', ':Tabularize /:/l0c1<CR>', {desc = 'Align at :'})
        vim.keymap.set({'n', 'v'}, '<leader>a,', ':Tabularize /,/l0c1<CR>', {desc = 'Align at ,'})
    end
}
