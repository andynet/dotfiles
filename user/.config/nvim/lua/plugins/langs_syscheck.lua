-- This will check all the system dependencies for languages

local languages = require('languages')

for _, lang in pairs(languages) do
    if lang.system_deps then
        -- vim.print(lang.system_deps)
        for _, cmd in ipairs(lang.system_deps) do
            vim.fn.system(cmd)
            if vim.v.shell_error == 0 then
                vim.print('SUCCESS: ' .. cmd)
            else
                vim.print('FAIL: ' .. cmd)
            end
        end
    end
end

return {}
