return {
    system_deps = {'zig version'},
    tools = {'zls'},
    treesitter = {'zig'},
    lsp = function(lspconfig, capabilities)
        vim.g.zig_fmt_autosave = 0
        lspconfig.zls.setup({
            capabilities = capabilities,
            -- enable_build_on_save = true,
            -- build_on_save_step = "check"
        })
    end,
}
