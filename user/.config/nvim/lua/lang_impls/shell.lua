return {
    tools = {'shellcheck'},
    null = function(null_ls)
        return {
            -- null_ls.builtins.diagnostics.fish,
            require('null-ls.builtins.diagnostics.fish'),
            require('none-ls-shellcheck.diagnostics'),
            require('none-ls-shellcheck.code_actions'),
        }
    end,
}
