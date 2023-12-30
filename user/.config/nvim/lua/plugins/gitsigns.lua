return {
    'lewis6991/gitsigns.nvim',
    config = function()
        require('gitsigns').setup()
        vim.keymap.set('n', '<leader>gb', ':Gitsigns blame_line<CR>', {desc = 'Git blame'})
        vim.keymap.set('n', '<leader>gn', ':Gitsigns next_hunk<CR>', {desc = 'Git next hunk'})
        vim.keymap.set('n', '<leader>gv', ':Gitsigns preview_hunk<CR>', {desc = 'Git view hunk'})
        vim.keymap.set('n', '<leader>gu', ':Gitsigns reset_hunk<CR>', {desc = 'Git undo'})
    end
}
