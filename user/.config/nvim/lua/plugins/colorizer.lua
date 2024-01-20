return {
    'chrisbra/Colorizer',
    config = function()
        vim.keymap.set('n', '<leader>cc', ':ColorToggle<CR>', {desc = 'Toggle color'})
    end
}
