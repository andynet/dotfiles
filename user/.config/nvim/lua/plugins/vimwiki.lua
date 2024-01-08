return {
    'vimwiki/vimwiki',
    init = function()
        vim.g.vimwiki_global_ext = 0 -- turn off creation of temporary wikis
        vim.g.vimwiki_list = {
            {path = '~/data/knowledge_vault', syntax = 'markdown', ext = '.md'}
        }
    end
}
