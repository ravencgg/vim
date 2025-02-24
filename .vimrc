""""""""""""""""""""""""""""""""
" Plugin Management            "
""""""""""""""""""""""""""""""""

"if has('nvim')
"    cd C:\Projects
"    colorscheme gruvbox
"    inoremap <C-s> <esc>:w<CR>
"    vmap <C-s> <esc>:w<CR>gv
"    nnoremap <silent> <C-S> :w<CR>
"    imap {<CR> {<CR>}<Up><C-o>o
"endif

" I would rather this go into the .gvimrc file, but that is loaded
" too late in the initialization process, so packages have already
" finished loading at that point.
if has("gui_running")        " || has('nvim')
    if has('win32') || has('win64')
        set runtimepath-=~/vimfiles
        set runtimepath^=~/.vim
        set runtimepath-=~/vimfiles/after
        set runtimepath+=~/.vim/after
        set packpath-=~/vimfiles
        set packpath^=~/.vim
        set packpath-=~/vimfiles/after
        set packpath+=~/.vim/after
    endif

    "set laststatus=2
    set lines=40 columns=150
endif

if (has('nvim'))
    cd C:\Projects
endif

" configure gruvbox
if filereadable(expand("~/.vim/colors/gruvbox.vim"))

    " Disable italics helps non-Consolas fonts render correctly. Others render
    " out of the bounding box and cause pixels to be incorrect until redrawn.
    let g:gruvbox_italic=0

    let g:gruvbox_bold = '1'
    let g:gruvbox_undercurl = '1'
    let g:gruvbox_vert_split = 'bg4'
    "let g:gruvbox_contrast_dark = 'soft'
    "let g:gruvbox_contrast_dark = 'medium'
    let g:gruvbox_contrast_dark = 'hard'
    let g:gruvbox_contrast_light = 'hard'
    nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
    nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
    nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>

    nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
    nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
    nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

    colorscheme gruvbox
endif

" Highlight functions in cpp files (used in .vim/after/syntax/cpp.vim)
let g:c_function_highlight = '1'

" Default to dark theme
set background=dark
function! ToggleBackground()
    let &background = ( &background == "dark"? "light" : "dark" )
    if exists("g:colors_name")
        exe "colorscheme " . g:colors_name
    endif
endfunction

" More natural movement when wrapping is enabled
" Must use :call ToggleWrap() to toggle instead of 'set wrap'
let s:wrapenabled = 0
function! ToggleWrap()
  set wrap nolist
  if s:wrapenabled
    set nolinebreak
    unmap j
    unmap k
    unmap 0
    unmap ^
    unmap $
    let s:wrapenabled = 0
  else
    set linebreak
    nnoremap j gj
    nnoremap k gk
    nnoremap 0 g0
    nnoremap ^ g^
    nnoremap $ g$
    vnoremap j gj
    vnoremap k gk
    vnoremap 0 g0
    vnoremap ^ g^
    vnoremap $ g$
    let s:wrapenabled = 1
  endif
endfunction
" This seems to be missing something when toggling, setwrap doesn't always get
" applied correctly.
" map <leader>w :call ToggleWrap()<CR>


if has("directx")
    set encoding=utf-8
    "set renderoptions=type:directx,gamma:1.5,contrast:1.0,geom:1,renmode:4,taamode:1,level:1.0
    set renderoptions=type:directx,gamma:1.8,contrast:0.5,geom:1,renmode:5,taamode:1,level:0.5
endif

" ctrlp ignore directories
" to ignore an additional directory (like 'build') use this:
" \ 'dir': 'build\|\v[\/]\.(git|hg|svn)$',
let g:ctrlp_custom_ignore = {
    \ 'dir': 'build\|\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll|obj|lib|exp|pdb)$',
    \ }

""""""""""""""""""""""""""""""""
" Building with batch file     "
""""""""""""""""""""""""""""""""

" nnoremap <F6> :make<cr> :copen<cr>

" nnoremap <C-b> :make<cr>
"
" AsyncRun plugin: invoke build.bat
" NOTE: use :AsyncStop to stop a build
" NOTE: has('win32unix') returns true for vim running in git bash< win32 and
" win64 return false in that environment
let g:asyncrun_open=10
if has('win32') || has('win64') || has('win32unix')
    nnoremap <C-b> :AsyncRun run_build.bat<cr>
else
    " Note this is not the same behavior as windows. It only runs from the
    " current directory.
    nnoremap <C-b> :AsyncRun ./build.sh<cr>
endif

" Map both F7 and Shift F8 to previous quickfix the
" shift version mirrors VS, but won't work well in
" the terminal.
nnoremap <F7> :cp<cr>
nnoremap <S-F8> :cp<cr>
nnoremap <F8> :cn<cr>

if has('win32') || has('win64') || has('win32unix')
    "I _think_ this is for cl.exe:
    "set errorformat+=\\\ %#%f(%l\\\,%c):\ %m

    "Error format for MSBuild
    "set errorformat=\ %#%f(%l\\\,%c):\ %m
    "This overrides the makefile program:
    compiler! msbuild
    "compiler! msvc
endif

" Error format for the Odin programming language
set errorformat+=%f(%l:%c)\ %m

" This is for cl.exe:
set errorformat+=\\\ %#%f(%l):\ %m

" Keep this after compiler! to override the makeprg that it sets
" Search for a build.bat in any parent folder and execute it
" This file is in vimfiles/my_files but must be moved to a
" place in the path to use it
set makeprg=run_build.bat

""""""""""""""""""""
" LEADER KEY BEGIN "
""""""""""""""""""""
map <space> <leader>

" Toggle background between dark and light
nnoremap <leader><space>b :call ToggleBackground()<cr>
nnoremap <leader>b :ls<cr>:b<space>

" Resize vertical splits
nnoremap <leader>= :resize +10<cr>
nnoremap <leader>- :resize -10<cr>

" Resize vertical splits Large
nnoremap <leader><space>= :resize +40<cr>
nnoremap <leader><space>- :resize -40<cr>

" Resize horizontal splits
nnoremap <leader>] :vertical resize +10<cr>
nnoremap <leader>[ :vertical resize -10<cr>

" Resize horizontal splits Large
nnoremap <leader><space>] :vertical resize +40<cr>
nnoremap <leader><space>[ :vertical resize -40<cr>

" Center the screen on the cursor, removed to use the keybind for buffer
" deletion
" nnoremap <leader>c :normal zz<cr>

" Save with w
nnoremap <leader>w :w<cr>

" Close current window, won't close program
nnoremap <leader>q :close<cr>

" Delete the current buffer, and return to the previous file
nnoremap <leader>c :bp\|bd #<cr>

" Sort the current paragraph, useful for sorting a list of included files
nnoremap <leader>x vip:sort<cr>

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
" NOTE: To open a file this way on Windows, use backslashes
nnoremap <leader>r :silent !start<space>

" Run a terminal in the current directory
" DEPRECATED: Using vim's new :terminal mode in 8.1
"nnoremap <leader>t :silent ! start cmd .<cr>

" Disable highlighting after a search, used to be on Esc, but that breaks
" terminal vim sessions
nnoremap <leader>n :noh<cr>

" C++ style comment visually selected lines
vnoremap <leader>/ :s/^/\/\/<cr><esc>    :noh<cr>
" C++ style uncomment visually selected lines
vnoremap <leader><space>/ :s/\/\///<cr> :noh<cr>

" Shortcut to yanking to the system clipboard
" NOTE: These used to be the "* register, but + actually maps to Ctrl-C so it
" should be more what is expected.
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader><space>p "+p
vnoremap <leader><space>p "+p
" Old:
"map <leader><space>y "*y
"map <leader><space>p "*p
" Unused:
" map <leader><C-v> "*P

" Start a text search
nnoremap <leader>/ :vimgrep // **/*<Left><Left><Left><Left><Left><Left>

" Use ripgrep as the grep program, must be visible in the PATH somewhere
" (callable as 'rg'). This populates the quickfix window in a similar manner
" as vimgrep. The only downside to this that I know of is Ctrl-C won't cancel
" the search, you have to close the terminal window that opened.
" :grep search_string
" Put the search string in double quotes to search for multiple words
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Start a file search (use <tab>, not <cr>!)
nnoremap <leader>f :e **/

" Set the current file's syntax highlighting to c++
nnoremap <leader>s :set syntax=cpp<cr>

" Open the .vimrc file
nnoremap <leader>vf :e $HOME/.vimrc<cr>

" Set to cpp syntax highlighting
nnoremap <leader>s :set syntax=cpp<cr>

" Reload .vimrc file - disabled unless making changes in the vimrc
nnoremap <leader>vr :so $MYVIMRC<cr>

" store session:
nnoremap <leader>m :mks c:\temp\session2.vim<cr>
" reload session:
" source <filename>

" Redraw screen (Clears lit pixels from GVim)
" :redr!

""""""""""""""""""
" LEADER KEY END "
""""""""""""""""""

" Use forward slashes for path completion on Windows
if has('win32') || has('win64')
    set ssl
endif

" Shift + k brings up help, which is sometimes useful, but often accidental
map <S-k> <Nop>

" Don't look in included files for ctrl+n autocomplete
set complete-=i

" Don't look in tags files for ctrl+n autocomplete
set complete-=t

" I think the semicolon means to search up recursively for the tags file named
" 'tags' here.
set tags=tags;

set completeopt-=preview

" There is a copy of ctags.exe in vimfiles/my_files
" Example usage:
" ctags.exe --language-force=C++ -R

" NOTE: Search for files from the current working directory with
" :e **/filename.ext // Recursive search
" :e **/*.h\>        // Finds all .h files, won't find .hpp

" Y functions like D, yanking until the end of the line
nnoremap Y y$

" Control ] is jump to tag. Add a zz at the end of it to always center the
" screen on the tag after jumping
nnoremap <C-]> <C-]>zz

" hitting j k in insert mode will hit return to normal mode
inoremap jk <esc>
inoremap jK <esc>
inoremap Jk <esc>
inoremap JK <esc>

" Shift + Enter will split the line at the cursor in normal mode (== to auto
" align after the split.
"nnoremap <S-CR> i<CR><Esc>==
nnoremap <S-CR> i<CR><Esc>

" Don't indent case labels in switch statement
set cinoptions=:0,l1

" NOTE: This is still happening on windows, but not on Mac for some reason
" Silence the netrw from asking on "e ." commands
" :silent Exp " Not functioning ?!!?
let g:netrw_silent=1
set shortmess+=T

" hide . and .. in netrw
"let g:netrw_list_hide='.*\.swp$'
let g:netrw_list_hide = '^\./$,^\.\./$'
let g:netrw_hide = 1

" disable vi compatibility (emulation of old bugs)
set nocompatible

" Allow plugins
filetype plugin on

" Set font. This is a list that VIM will use as fallbacks.
if (has('nvim'))
    " set guifont=Inconsolata:h12:cANSI:qDRAFT,
    set guifont=Lucida\ Console:h12:cANSI:qDRAFT,Roboto\ Mono:h11:cANSI,Consolas:h11:cANSI
else
    " Interesting, but hard to get working correctlY: ProggyCleanTTF:h12:cANSI:qDRAFT,
    set guifont=Lucida_Console:h11:cANSI:qDRAFT,Roboto\ Mono:h11:cANSI,Consolas:h11:cANSI
endif

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

" Don't allow switching from an unsaved buffer
set nohidden

" Persistent undo
" Be sure to create the undodir directory!!
set undofile
if (has('nvim'))
    set undodir=$HOME/.vim/nvim_undo
else
    set undodir=$HOME/.vim/undo
endif
set undolevels=1000
set undoreload=10000

" Better command-line completion
set wildmenu

if v:version >= 900
    " Vertical command-line completion list (vim 9 feature)
    set wildoptions+=pum
endif

" Allow backspacing over autoindent, line breaks and start of insert action
" set backspace=indent,eol,start
set backspace=indent,start

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

if v:version >= 801
    " Terminal: vim 8.1 terminal
    tmap <C-j> <C-w>j
    tmap <C-k> <C-w>k
    tmap <C-h> <C-w>h
    tmap <C-l> <C-w>l
    tmap <esc> <C-\><C-n>
    tmap <C-V> <C-W>"0

    " Launch git bash
    function! <SID>OpenTerminal()
        let term = "C:\\Program Files\\Git\\bin\\sh.exe"
        let dict = {'term_name' : 'Git Bash',
                    \ 'term_kill' : 'term',
                    \ 'term_finish' : 'close',
                    \ 'curwin' : '1', }
        call term_start(term, dict)
    endfun
    nnoremap <leader>t :call <SID>OpenTerminal()<cr>

    " Allow hidden terminal buffer
    autocmd BufWinEnter * if &buftype == 'terminal' | setlocal bufhidden=hide | endif
    " End Terminal:
endif

" Highlight the line that the cursor is on
set cursorline

" Disable looking through included files when doing autocomplete with ctrl-n
set complete-=i

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
function! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre .vimrc,*.h,*.c,*.cpp,*.hpp,*.C,*.java,*.glsl,*.hlsl,*.lua,*.jai,*.odin :call StripTrailingWhitespaces()
" NOTE: do :autocmd! BufWritePre
" to disable this trailing whitespace stripping for the current Vim
"End strip trailing spaces

" Delete buffers that aren't visible
function DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction
"

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
