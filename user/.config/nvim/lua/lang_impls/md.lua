return {
    system_deps = {'zk --version'},
    lazy = {
        {
            'zk-org/zk-nvim',
            config = function()
                require('zk').setup({
                    -- picker = 'select',
                    picker = 'telescope',
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
                -- uses https://github.github.com/gfm/
                -- TODO: :h vimwiki
                -- :VimwikiFollowLink   -- this is mapped to <Enter> Thanks god!
                -- :VimwikiGoBackLink   -- this is mapped to <Backspace>
                -- :VimwikiNextLink     -- <Tab>
                -- :VimwikiPrevLink     -- <Shift-Tab>
                -- :VimwikiDeleteFile   -- this should never be used
                -- :VimwikiAll2HTML[!]  -- not supported for md :-(
            end
        },
        -- peek is outdated
        -- https://github.com/selimacerbas/markdown-preview.nvim might be better
        {
            'toppair/peek.nvim',
            event = {'VeryLazy'},
            build = 'deno task --quiet build:fast',
            config = function()
                require('peek').setup({
                    auto_load = true,
                    close_on_bdelete = true,
                    syntax = true,
                    theme = 'dark',
                    update_on_change = true,
                    app = {'boxxy', 'firefox', '--new-window'},
                    filetype = {'markdown', 'vimwiki'},
                })
                vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
                vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
                vim.keymap.set('n', '<leader>zm', ':PeekOpen<CR>', {desc = 'Peek Open'})
            end,
        },
    },
    -- tools = {},
    -- treesitter = {},
    -- null = function(null_ls) end,
    -- lsp = function(lspconfig, capabilities) end,
    -- dap = function() end,
}
