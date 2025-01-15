return {
    tools = {'texlab'},             -- ltex-ls (for grammar check)
    system_deps = {'tectonic'},     -- chktex (some nice linter)
    lsp = function(lspconfig, capabilities)
        vim.fn.system('tectonic -h > /dev/null')
        if vim.v.shell_error ~= 0 then return end

        local texlab = {
            build = {
                -- onSave = true,
                executable = 'tectonic',
                args = {
                    '%f', '--keep-intermediates', '--keep-logs',
                    '--synctex', '--untrusted'
                },
            },
            formatterLineLength = 10000,
        }
        lspconfig.texlab.setup({
            capabilities = capabilities,
            settings = {texlab = texlab}
        })
        vim.keymap.set('n', '<C-x>', ':TexlabBuild<CR>', {desc = 'Build TeX'})
        -- lspconfig.ltex.setup({})
    end,
}
