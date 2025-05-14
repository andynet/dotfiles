return {
    tools = {'texlab'},
    system_deps = {'tectonic -V', 'ltex-ls-plus --version'},
    lsp = function(lspconfig, capabilities)
        vim.fn.system('tectonic -h > /dev/null')
        if vim.v.shell_error ~= 0 then return end

        lspconfig.texlab.setup({
            capabilities = capabilities,
            settings = {
                texlab = {
                    build = {
                        executable = 'tectonic',
                        args = {'%f', '--keep-intermediates', '--keep-logs', '--synctex', '--untrusted'},
                    },
                    formatterLineLength = 10000,
                }
            }
        })
        vim.keymap.set('n', '<C-x>', ':TexlabBuild<CR>', {desc = 'Build TeX'})

        -- Why does this run also for txt?
        -- lspconfig.ltex_plus.setup({
        -- --     capabilities = capabilities,
        -- --     on_attach = function(_, _)
        -- --         -- /home/balaz/.local/share/nvim/lazy/ltex-extra.nvim/lua/ltex_extra/commands-lsp.lua
        -- --         -- change l.55 name="ltex" to name = "ltex_plus",
        -- --         require('ltex_extra').setup({})
        -- --     end,
        --     settings = {
        --         ltex = {
        --             -- https://ltex-plus.github.io/ltex-plus/settings.html
        --             -- enabled = {'tex', 'latex'},
        --             enabled = false,
        --             language = 'en-US',
        --             checkFrequency = 'save',
        --             additionalRules = {
        --                 enablePickyRules = true,
        --                 -- https://dev.languagetool.org/finding-errors-using-n-gram-data
        --                 languageModel = '/home/balaz/data/ngrams-en-20150817',
        --             },
        --         },
        --     },
        -- })
    end,
    -- lazy = {'barreiroleo/ltex-extra.nvim'}
}
