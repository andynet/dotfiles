-- https://myriad-dreamin.github.io/tinymist/frontend/neovim.html
return {
    tools = {'tinymist'},
    system_deps = {'typst -V'},
    -- lazy = {},
    treesitter = {'typst'},
    -- null = function(null_ls) end,
    lsp = function(lspconfig, capabilities)
        lspconfig.tinymist.setup{
            settings = {
                formatterMode = 'typstyle',
                exportPdf = 'onType',
                semanticTokens = 'disable'
            }
        }
    end,
    -- dap = function() end,
}
