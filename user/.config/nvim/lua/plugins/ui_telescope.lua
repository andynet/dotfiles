return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {'nvim-lua/plenary.nvim'},
    config = function()
        require('telescope').setup({
            -- jumplist does not work as I want it.
            -- vim.keymap.set('n', '<leader>jl', ':Telescope jumplist<CR>', {desc = 'Telescope jumplist'})
        })
    end

}
