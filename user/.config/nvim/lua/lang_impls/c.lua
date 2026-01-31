return {
    tools = {'codelldb'},
    system_deps = {'bear --version', 'clangd --version'},
    treesitter = {'c'},
    lsp = function(lspconfig, capabilities)
        lspconfig.clangd.setup({
            capabilities = capabilities,
            filetypes = {'c', 'h'},
            cmd = {'clangd', '--log=verbose', '--clang-tidy', '--header-insertion=never'},
            root_markers = {
                -- '.clangd',
                -- '.clang-tidy',
                -- '.clang-format',
                'compile_commands.json',
                -- 'compile_flags.txt',
                -- 'configure.ac',
                '.git'
            }
        })
    end,
    dap = function() end,
}
