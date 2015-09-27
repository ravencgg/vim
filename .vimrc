" VIM Configuration File
" Description: Optimized for C/C++ development
"

" F2 will open the file explorer in the current directory
nnoremap <F2> :e .<CR>

" Build GLMario.vcxproj
nnoremap <F8> :e ..\GLMario.vcxproj<CR>:make<CR><C-6>

" Package control
" Currently using omnicppcomplete
execute pathogen#infect()

" disable vi compatibility (emulation of old bugs)
set nocompatible

" omnicppcomplete scratch pane disable. change - to + to reenable
set completeopt-=preview

" Allow plugins
filetype plugin on

" set font
set guifont=Consolas:h9:cANSI

" Disable audio and visual bells (error beeps and screen flashes)
" This must also be set in the gvimrc
set vb t_vb=

" Don't wrap long lines of text
set nowrap

" wrap lines at 120 chars. 80 is somewhat antiquated with nowadays displays.
" set textwidth=120

" Change working directory to the currently opened file's directory
set autochdir

" Allow switching from an unsaved buffer
" set hidden

" Disable swap file creation
" set noswapfile

" Better command-line completion
" set wildmenu

" Allow backspacing over autoindent, line breaks and start of insert action
" set backspace=indent,eol,start
set backspace=start

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
" set laststatus=2

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Insert both brackets at the proper indentation level when opening a bracket
imap { {<CR>}<Up><C-o>o

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Turn off search highlighting when pressing escape in normal mode
nnoremap <esc> :noh<return><esc>

" Enable search highlighting
set hlsearch

" Strip trailing whitespace on save
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre .vimrc,*.h,*.c,*.cpp,*.hpp,*.C,*.java :call <SID>StripTrailingWhitespaces()
"End strip trailing spaces

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
" turn syntax highlighting on
" Colorscheme settings are done in the .gimvrc to not affect the vim in git bash
set t_Co=256
syntax on
" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" Install OmniCppComplete like described on http://vim.wikia.com/wiki/C++_code_completion
" This offers intelligent C++ completion when typing . -> or <C-o>
" Load standard tag files
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl

" switch between header/source with F4
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" OMNICPPCOMPLETE TAGS: recreate tags file with F9
map <F9> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" create doxygen comment
" map <F6> :Dox<CR>

" build using makeprg with <F7>
map <F7> :make<CR>

" build using makeprg with <S-F7>
map <S-F7> :make clean all<CR>

" goto definition with F12
map <F12> <C-]>

" in diff mode we use the spell check keys for merging
" if &diff
"    diff settings
"   map <M-Down> ]c
"   map <M-Up> [c
"   map <M-Left> do
"   map <M-Right> dp
"   map <F9> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg
" else
"   " spell settings
"   :setlocal spell spelllang=en
"   " set the spellfile - folders must exist
"   set spellfile=~/.vim/spellfile.add
"   map <M-Down> ]s
"   map <M-Up> [s
" endif
