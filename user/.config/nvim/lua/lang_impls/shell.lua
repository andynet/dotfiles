return {
    tools = {'shellcheck'},
    null = function(_)
        return {
            require('null-ls.builtins.diagnostics.fish'),
            require('none-ls-shellcheck.diagnostics'),
            require('none-ls-shellcheck.code_actions'),
        }
    end,
}
