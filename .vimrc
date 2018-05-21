"
""""""""""""""""""""""""""""""""
" Plugin Management            "
""""""""""""""""""""""""""""""""

"set renderoptions=type:directx

if has("gui_running")
    set lines=40 columns=150
    set laststatus=2
endif

" set renderoptions=type:directx,gamma:1.5,contrast:0.5,geom:1,renmode:5,taamode:1,level:0.5

" ctrlp ignore directories "
let g:ctrlp_custom_ignore = 'build\|\.obj'

" airline + fugitive does this automatically
"if has("gui_running")
"    function! AirlineInit()
"        let g:airline_section_a = airline#section#create(['mode', ' ', 'branch'])
"    endfunction
"    autocmd VimEnter * call AirlineInit()
"endif

"set runtimepath^=~/.vim

""""""""""""""""""""""""""""""""
" Additional Type Highlighting "
""""""""""""""""""""""""""""""""

syn keyword cppType uint8 uint16 uint32 uint64 int8 int16 int32 int64 bool32 b32 u8 u16 u32 u64 i8 i16 i32 i64

""""""""""""""""""""""""""""""""
" Building with batch file     "
""""""""""""""""""""""""""""""""

" Search for a build.bat in any parent folder and execute it
set makeprg=run_build.bat
nnoremap <F6> :make<cr> :cw<cr>
" Map both F7 and Shift F8 to previous quickfix the
" shift version mirrors VS, but won't work well in
" the terminal.
nnoremap <F7> :cp<cr>
nnoremap <S-F8> :cp<cr>
nnoremap <F8> :cn<cr>

"set errorformat+=\\\ %#%f(%l\\\,%c):\ %m

""""""""""""""""""""
" LEADER KEY BEGIN "
""""""""""""""""""""
map <space> <leader>

" Resize vertical splits
nnoremap <leader>= :resize +10<cr>
nnoremap <leader>- :resize -10<cr>

" Resize horizontal splits
nnoremap <leader>] :vertical resize +10<cr>
nnoremap <leader>[ :vertical resize -10<cr>

" Center the screen on the cursor
nnoremap <leader>c :normal zz<cr>

" Save with w
nnoremap <leader>w :w<cr>

" Close current window, won't close program
nnoremap <leader>q :close<cr>

" Show the current working directory
nnoremap <leader>p :pwd<cr>
" Set all window's current directory to the file's directory
nnoremap <leader>d :cd %:p:h<cr>
" Set current window's current directory to the file's directory
nnoremap <leader>ld :lcd %:p:h<cr>
" Don't use the path, just set the current working directory and use :e to
" find files recursively
" DEPRECATED:           " Set the path to the current directory, recursive
                        " nnoremap <leader>sd :set path=%:p:h<cr>

" Set up to run a command in a new process
nnoremap <leader>r :silent ! start<space>

" Run a terminal in the current directory
"nnoremap <leader>t :silent ! start cmd .<cr>

" Disable highlighting after a search, used to be on Esc, but that breaks
" terminal vim sessions
nnoremap <leader>n :noh<cr>

" C++ style comment visually selected lines
vnoremap <leader>/ :s/^/\/\/<cr><esc>    :noh<cr>
" C++ style uncomment visually selected lines
vnoremap <leader><space>/ :s/\/\///<cr> :noh<cr>

" Shortcut to yanking to the system clipboard
map <leader><space>y "*y
map <leader><space>p "*p
" map <leader><C-v> "*P

" Start a text search
nnoremap <leader>/ :vimgrep /

" Start a file search (use <tab>, not <cr>!)
nnoremap <leader>f :e **/

" Open the .vimrc file
nnoremap <leader>vf :e $HOME/.vimrc<cr>

" Set to cpp syntax highlighting
nnoremap <leader>s :set syntax=cpp<cr>

" Reload .vimrc file - disabled unless making changes in the vimrc
nnoremap <leader>vr :so $MYVIMRC<cr>

" Redraw screen (Clears lit pixels from GVim)
" :redr!

""""""""""""""""""
" LEADER KEY END "
""""""""""""""""""

" Don't look in included files for ctrl+n autocomplete
set complete-=i


" NOTE: Search for files from the current working directory with
" :e **/filename.ext // Recursive search
" :e **/*.h\>        // Finds all .h files, won't find .hpp

" Y functions like D, yanking until the end of the line
nnoremap Y y$

" hitting j k in insert mode will hit escape
inoremap jk <esc>
inoremap Jk <esc>
inoremap JK <esc>

" NOTE: This is still happening on windows, but not on Mac for some reason
" Silence the netrw from asking on "e ." commands
" :silent Exp " Not functioning ?!!?
let g:netrw_silent=1
set shortmess+=T

" hide . and .. in netrw
"let g:netrw_list_hide='.*\.swp$'
let g:netrw_list_hide = '^\./$,^\.\./$'
let g:netrw_hide = 1

" F2 will open the file explorer in the current directory
" nnoremap <F2> :e .<CR>

" disable vi compatibility (emulation of old bugs)
set nocompatible

" omnicppcomplete scratch pane disable. change - to + to reenable
" set completeopt-=preview

" Allow plugins
filetype plugin on

" set font
set guifont=Consolas:h11:cANSI

" Disable audio and visual bells (error beeps and screen flashes)
" This must also be set in the gvimrc
set vb t_vb=

" Highlight the current line of text
set cursorline

" Don't wrap long lines of text
set nowrap

" wrap lines at 120 chars. 80 is somewhat antiquated with nowadays displays.
" set textwidth=120

" Change working directory to the currently opened file's directory
" set autochdir

" Allow switching from an unsaved buffer
" set hidden

" Persistent undo
" Be sure to create the undodir directory!!
set undofile
set undodir=$HOME/vimfiles/undo
set undolevels=1000
set undoreload=10000

" Disable swap file creation
" set noswapfile

" Better command-line completion
set wildmenu

" Allow backspacing over autoindent, line breaks and start of insert action
" set backspace=indent,eol,start
set backspace=indent,start

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
" Moved to the .gvimrc since this causes the visual studio status line to be
" twice as tall
" set laststatus=2

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Insert both brackets at the proper indentation level when opening a bracket
"imap {<CR> {<CR>}<Up><C-o>o
"MOVED TO GVIMRC TO NOT BE USED BY Visual Studio!

" Test this to see if it functions better for only happening after switching
" to the next line
" NOTE: does not work well, because it delays after the <CR> to see if the {
" is coming
" imap <CR>{ {<CR>}<Up><C-o>o

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" vim 8.1 terminal
tmap <C-j> <C-w>j
tmap <C-k> <C-w>k
tmap <C-h> <C-w>h
tmap <C-l> <C-w>l
tmap <esc> <C-\><C-n>
tmap <C-V> <C-W>"0i

" Launch git bash
" :terminal ++curwin "C:\\Program Files\\Git\\bin\\sh.exe"

function! <SID>OpenTerminal()
    let term = "C:\\Program Files\\Git\\bin\\sh.exe"
    let dict = {'term_name' : 'Git Bash',
                \ 'term_kill' : 'term',
                \ 'term_finish' : 'close',
                \ 'curwin' : '1', }
    call term_start(term, dict)
endfun
nnoremap <leader>t :call <SID>OpenTerminal()<cr>

" nvim terminal
"tnoremap <C-j> <C-w>j
"tnoremap <C-k> <C-w>k
"tnoremap <C-h> <C-w>h
"tnoremap <C-l> <C-w>l
"tnoremap <esc> <C-\><C-n>


" Highlight the line that the cursor is on
set cursorline

" Disable looking through included files when doing autocomplete with ctrl-n
set complete-=i

" Turn off search highlighting when pressing escape in normal mode
" NOTE: Rebound to <leader>n to avoid console screwups
"nnoremap <esc> :noh<cr><esc>

" Enable search highlighting
set hlsearch

" Ignore case if / searching with all lower case, but be case sensitive if
" there is a capital letter there. Override with \c \C
set ignorecase
set smartcase

" Incremental search on /
set incsearch

" no backups
set nobackup
set nowb
set noswapfile

" better indenting in visual mode
vnoremap <Tab> > gv
vnoremap <S-Tab> < gv

" Strip trailing whitespace on save
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre .vimrc,*.h,*.c,*.cpp,*.hpp,*.C,*.java,*.glsl :call <SID>StripTrailingWhitespaces()
"End strip trailing spaces

" Terminal: allow hidden buffer
autocmd BufWinEnter * if &buftype == 'terminal' | setlocal bufhidden=hide | endif
" End Terminal:

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

" switch between header/source with F4
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

