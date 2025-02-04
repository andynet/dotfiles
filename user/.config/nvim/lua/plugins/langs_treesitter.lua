return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        local languages = require('languages')
        local ensure_installed = {
            'html', 'css', 'javascript', 'json', 'xml', 'vim', 'vimdoc', 'cpp',
        }

        for _, lang in pairs(languages) do
            if lang.treesitter then
                for _, parser in ipairs(lang.treesitter) do
                    table.insert(ensure_installed, parser)
                end
            end
        end

        require('nvim-treesitter.configs').setup({
            modules = {'highlight'},
            sync_install = false,
            ensure_installed = ensure_installed,
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
