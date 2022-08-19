call plug#begin(expand('~/.config/nvim/plugged'))
    Plug 'morhetz/gruvbox'
"    Plug 'dense-analysis/ale'
"    Plug 'neovim/nvim-lspconfig' this is a 0.5 feature... WTF
call plug#end()

filetype plugin indent on
set softtabstop=4
set shiftwidth=4
set expandtab

syntax on
set ruler
set number
set colorcolumn=80
set nowrap
highlight ColorColumn ctermbg=darkgray

colorscheme gruvbox
set background=dark
set showfulltag
set showtabline=2
" set statusline=
set tags+=~/.config/nvim/systags

" paths determined with cpp -v
set path=/usr/lib/gcc/x86_64-linux-gnu/9/include
set path+=/usr/local/include
set path+=/usr/include/x86_64-linux-gnu
set path+=/usr/include
set path+=.

set listchars=tab:>\ ,trail:.
set list

packadd termdebug
nnoremap DBG :Termdebug<CR><C-w>j<C-w>j<C-w>L<C-w>h<C-w>k
tnoremap <Esc> <C-\><C-n>

au BufRead,BufNewFile *.h,*.c   set filetype=c
" au BufNewFile,BufRead Snakefile set filetype=snakemake         
" au BufNewFile,BufRead *.smk     set filetype=snakemake         

" au FileType snakemake   setlocal syntax=snakemake              
" au FileType make        setlocal tabstop=8 noexpandtab         
" au FileType c           setlocal foldmethod=syntax foldlevel=3 

highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17          
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17          
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17          
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88          


" set exrc
" set secure

" set makeprg=make\ -C\ ../build\ -j9
" nnoremap <F4> :make!<cr>
" nnoremap <F5> :!./my_great_program<cr>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-L> :let @/=""<CR>
