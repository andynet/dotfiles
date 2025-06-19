-- should this be in ./../lang_impls/ ?

return {
    {
        'quarto-dev/quarto-nvim',
        dependencies = {
            'jmbuhr/otter.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        config = function()
            local quarto = require('quarto')
            quarto.setup{
                debug = false,
                closePreviewOnExit = true,
                lspFeatures = {
                    enabled = true,
                    chunks = 'curly',
                    languages = {'python', 'bash'},
                    diagnostics = {
                        enabled = true,
                        triggers = {'BufWritePost'},
                    },
                    completion = {
                        enabled = true,
                    },
                },
                codeRunner = { enabled = false }
            }
        end,
    },
}
