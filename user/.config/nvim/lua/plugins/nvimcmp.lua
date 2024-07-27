return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'dcampos/cmp-snippy',
        'dcampos/nvim-snippy',
    },
    config = function()
        local cmp = require('cmp')
        local snippy = require('snippy')
        snippy.setup({})

        -- fn(cmp.Entry, cmp.Context): boolean
        local entry_filter = function(entry, _)
            return cmp.lsp.CompletionItemKind[entry:get_kind()] ~= 'Snippet'
        end

        -- fn(cmp.Entry, vim.CompletedItem): vim.CompletedItem
        local format_func = function(_, vim_item)
            vim_item.menu = nil
            return vim_item
        end

        cmp.setup({
            snippet = {
                expand = function(args) snippy.expand_snippet(args.body) end
            },
            mapping = cmp.mapping.preset.insert({
                ['<CR>']    = cmp.mapping.confirm(),
                ['<C-j>']   = cmp.mapping.scroll_docs(5),
                ['<C-k>']   = cmp.mapping.scroll_docs(-5),
            }),
            sources = {
                {name = 'nvim_lsp', entry_filter = entry_filter},
                {name = 'nvim_lsp_signature_help'},
                {name = 'path'},
                {name = 'buffer'},
            },
            formatting = {
                format = format_func,
            },
        })
    end
}
