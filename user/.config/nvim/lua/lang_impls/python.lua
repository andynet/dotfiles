return {
    -- tools = {'python-lsp-server', 'debugpy'},
    system_deps = {'mypy', 'pylint', 'python-lsp-server'},
    lsp = function(lspconfig, capabilities)
        lspconfig.pylsp.setup({capabilities = capabilities})
    end,
    null = function(null_ls)
        -- mypy --install-types .
        vim.fn.system('mypy -h > /dev/null')
        if vim.v.shell_error == 0 then
            return {
                null_ls.builtins.diagnostics.mypy,
                -- null_ls.builtins.diagnostics.pylint.with({timeout = 30000}),
            }
        else
            vim.notify('mypy not installed: pip install mypy')
            return {}
        end
    end,
    dap = function(dap)
        dap.adapters.python = {
            type = 'executable';
            command = 'python';
            args = {'-m', 'debugpy.adapter'};
        }
        dap.configurations.python = {{
            name = 'Launch';
            type = 'python';
            request = 'launch';
            program = '${file}';
            args = function()
                return vim.split(vim.fn.input('args: '), ' ')
            end,
            pythonPath = function() return 'python' end;
        }}
    end,
}
