-- How to do something like this?
-- local languages = require('languages')

local languages = {
    snakemake = require('languages.snakemake'),
    just = require('languages.just'),
    tex = require('languages.tex'),
    rust = require('languages.rust'),
}

return {
    languages.snakemake.lazy,
    languages.just.lazy,
    languages.tex.lazy,
    languages.rust.lazy
}
