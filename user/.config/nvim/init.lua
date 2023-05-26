-- https://neovim.io/doc/user/lua-guide.html#lua-guide

vim.keymap.set("i", "<C-s>", "<ESC>:w<CR>")
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")
vim.keymap.set("n",     "x",         '"_x')
vim.keymap.set("n", "<C-D>", ":Termdebug<CR><C-w>j<C-w>j<C-w>L<C-w>h<C-w>k")
vim.keymap.set("n", "<C-t>", ":tabnew<CR>")

vim.opt.listchars = "tab:> ,trail:."
vim.opt.list = true
vim.opt.colorcolumn = "80"
vim.opt.columns = 85
vim.opt.clipboard:append("unnamedplus")
vim.opt.number = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false

vim.cmd("highlight ColorColumn ctermbg=darkgray")
vim.cmd("packadd termdebug")

