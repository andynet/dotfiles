    -- lsp = function(lspconfig, capabilities)
    --     lspconfig.pylsp.setup({
    --         capabilities = capabilities,
    --         settings = {
    --             pylsp = {
    --                 configurationSources = 'pycodestyle',
    --                 plugins = {
    --                     -- flake8 = {
    --                     --     ignore = {'E501'},
    --                     --     maxLineLength = 120
    --                     --     -- config = ...
    --                     -- },
    --                     pyflakes = {
    --                         enabled = false
    --                     },
    --                     pycodestyle = {
    --                         ignore = {'E501'},
    --                         maxLineLength = 120
    --                     }
    --                 }
    --             }
    --         }
    --     })
    -- end,

return {
    system_deps = {'mypy -V', 'pylint -h', 'pylsp -V'},
    treesitter = {'python'},
    lsp = function(lspconfig, capabilities)
        lspconfig.pylsp.setup({
            capabilities = capabilities,
            settings = {
                pylsp = {
                    plugins = {
                        -- pycodestyle = {enabled = false},
                        pycodestyle = {
                            maxLineLength = 120
                        },
                        -- pyflakes = {enabled = false},
                        mccabe = {enabled = false},
                    },
                },
            },
            on_init = function(client)
                -- Look for .venv in the project root
                local root = client.workspace_folders[1].name
                local venv = root .. '/.venv/bin/python'

                -- If it exists, use it for pylsp analysis
                if vim.fn.executable(venv) == 1 then
                    client.config.settings.pylsp.plugins.jedi = {
                        environment = venv,
                    }
                end
            end,
        })
    end,
    null = function(null_ls)
        -- return {}
        -- mypy --install-types .
        vim.fn.system('mypy -h > /dev/null')
        if vim.v.shell_error == 0 then
            return {
                null_ls.builtins.diagnostics.mypy,
                -- null_ls.builtins.diagnostics.pylint.with({timeout = 30000}),
            }
        else
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
