return {
    'chrisbra/Colorizer',
    config = function()
        vim.keymap.set('n', '<leader>c', ':ColorToggle<CR>', {desc = 'Toggle color'})
    end
}
