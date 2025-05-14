-- This will check all the system dependencies for languages
return {
    dir = vim.fn.stdpath('config'), -- this is a no-op needed for fake plugin
    dependencies = {'j-hui/fidget.nvim'},
    config = function()
        vim.schedule(function()     -- schedule postpones execution right after the start so the start up time is not slow
            local languages = require('languages')

            for _, lang in pairs(languages) do
                if lang.system_deps then
                    for _, cmd in ipairs(lang.system_deps) do
                        vim.fn.system(cmd)
                        if vim.v.shell_error == 0 then
                            vim.notify(cmd .. ' - SUCCESS')
                        else
                            vim.notify(cmd .. ' - FAIL   ')
                        end
                    end
                end
            end
        end)
    end
}
