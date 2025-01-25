local languages = require('languages')
-- vim.print(languages)

return {
    languages.snakemake.lazy,
    languages.just.lazy,
    languages.tex.lazy,
    languages.rust.lazy
}
