local languages = require('languages')

for _, lang in pairs(languages) do
    if lang.system_deps then
        -- vim.fn.system('echo Hello')
        -- vim.notify('echo Hello run')
    end
        -- vim.fn.system('mypy -h > /dev/null')
        -- if vim.v.shell_error == 0 then
        --     return {
        --         null_ls.builtins.diagnostics.mypy,
        --         -- null_ls.builtins.diagnostics.pylint.with({timeout = 30000}),
        --     }
        -- else
        --     vim.notify('mypy not installed: pip install mypy')
        --     return {}
        -- end
end

return {}
