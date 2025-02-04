local languages = require('languages')
-- vim.print(languages)

local result = {}
for _, lang in pairs(languages) do
    if lang.lazy then
        table.insert(result, lang.lazy)
    end
end

-- vim.print(result)
return result
