

" These are here so the vim inside of git bash does not try to use this sweet ass color scheme
cd C:\Projects\
"colorscheme slate
"colorscheme torte 
colorscheme vividchalk 


" Save file from insert mode
inoremap <C-s> <esc>:w<CR>
" Save file from visual mode
vmap <C-s> <esc>:w<CR>gv
" Save file from normal mode
nnoremap <silent> <C-S> :w<CR>

" Insert both brackets at the proper indentation level when opening a bracket
imap {<CR> {<CR>}<Up><C-o>o

" Always display the status line, even if only one window is displayed
" Moved to the .gvimrc since this causes the visual studio status line to be
" twice as tall
" set laststatus=2

"remove menu bar
":set guioptions-=m

"remove toolbar
:set guioptions-=T  

"remove right-hand scroll bar
:set guioptions-=r  

"remove left-hand scroll bar
:set guioptions-=L  

" remove visual bells from GVIM -> Duplicated from .vimrc
set t_vb=
