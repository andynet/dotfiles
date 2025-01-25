return {{
    'williamboman/mason.nvim',
    config = function() require('mason').setup() end
}, {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    config = function()
        local languages = require('languages')
        local tools = {}
        for _, lang in pairs(languages) do
            if lang.tools then
                for _, tool in ipairs(lang.tools) do
                    table.insert(tools, tool)
                end
            end
        end

        require('mason-tool-installer').setup({ensure_installed = tools})
    end
}}
