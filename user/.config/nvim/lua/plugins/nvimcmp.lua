return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'dcampos/cmp-snippy',
        'dcampos/nvim-snippy',
    },
    config = function()
        local cmp = require('cmp')
        local snippy = require('snippy')
        snippy.setup({})

        cmp.setup({
            snippet = {
                expand = function(args) snippy.expand_snippet(args.body) end
            },
            mapping = cmp.mapping.preset.insert({
                ['<Tab>']   = cmp.mapping.select_next_item(),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                ['<C-j>']   = cmp.mapping.scroll_docs(5),
                ['<C-k>']   = cmp.mapping.scroll_docs(-5),
                ['<CR>']    = cmp.mapping.confirm({select = true}),
            }),
            sources = {
                {name = 'nvim_lsp'},
                {name = 'path'},
                {name = 'buffer'},
            }
        })
    end
}
