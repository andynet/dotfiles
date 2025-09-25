return {
    system_deps = {'zk --version'},
    lazy = {
        {
            'zk-org/zk-nvim',
            config = function()
                require('zk').setup({
                    picker = 'select',
                    lsp = {
                        config = {
                            name = 'zk',
                            -- zk lsp -W ~/data/zettelkasten/
                            cmd = {'zk', 'lsp', '-W', '~/data/zettelkasten'},
                            filetypes = {'markdown'},
                        },

                        auto_attach = {
                            enabled = true,
                        },
                    },
                })
                vim.keymap.set('n', '<leader>zn', ':ZkNew<CR>', {desc = 'ZkNew'})
                vim.keymap.set('n', '<leader>zl', ':ZkInsertLink<CR>', {desc = 'ZkInsertLink'})
                vim.keymap.set('n', '<leader>zb', ':ZkBacklinks<CR>', {desc = 'ZkBacklinks'})
                vim.keymap.set('n', '<leader>zt', ':ZkTags<CR>', {desc = 'ZkTags'})
            end
        },
        {
            'vimwiki/vimwiki',
            init = function()
                vim.g.vimwiki_global_ext = 0 -- turn off creation of temporary wikis
                vim.g.vimwiki_list = {
                    {path = '~/data/zettelkasten',    index = '00000000', ext = '.md', syntax = 'markdown'},
                    {path = '~/data/knowledge_vault', index = 'index',    ext = '.md', syntax = 'markdown'}
                }
                -- TODO: :h vimwiki
                -- :VimwikiFollowLink   -- this is mapped to <Enter> Thanks god!
                -- :VimwikiGoBackLink   -- this is mapped to <Backspace>
                -- :VimwikiNextLink     -- <Tab>
                -- :VimwikiPrevLink     -- <Shift-Tab>
                -- :VimwikiDeleteFile   -- this should never be used
                -- :VimwikiAll2HTML[!]  -- not supported for md :-(
            end
        }
    },
    -- tools = {},
    -- treesitter = {},
    -- null = function(null_ls) end,
    -- lsp = function(lspconfig, capabilities) end,
    -- dap = function() end,
}
