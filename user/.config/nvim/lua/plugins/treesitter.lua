return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.configs').setup({
            modules = {'highlight'},
            sync_install = false,
            ensure_installed = {
                'rust', 'python', 'c', 'cpp', 'lua',
                'vimdoc', 'vim', 'json', 'xml',
                'html', 'css', 'javascript',
            },
            ignore_install = {},
            auto_install = false,

            highlight = {enable = true},
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection   = '<M-Space>',
                    node_incremental = '<M-Space>',
                    node_decremental = '<M-b>'
                }
            },
        })
        vim.o.foldmethod = 'expr'
        vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
        vim.o.foldlevel = 10
    end
}
