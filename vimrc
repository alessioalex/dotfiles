" Environment {

    " Basics {
        set nocompatible        " Forget compatibility with vi - must be first line
        set background=dark     " Assume a dark background
    " }

     " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'
        " this makes synchronization across (heterogeneous) systems easier.
        if has('win32') || has('win64')
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }

    " Includes {

        " Custom functions library
        source $HOME/.vim/includes/functions.vim

        " This file contains all the abbreviations
        source $HOME/.vim/includes/abbreviations.vim 

        " This file contains all the plugin customizations
        source $HOME/.vim/includes/plugin_settings.vim 
    " }

    " Setup Bundle Support {
        " The next two lines ensure that the ~/.vim/bundle/ system works
        call pathogen#runtime_append_all_bundles()
        call pathogen#helptags()
    " }

" }

" General {
    filetype plugin indent on   " Automatically detect file types
    syntax on                   " Turn on syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide mouse when typing
    set splitbelow              " Splits window BELOW current window
    set splitright              " Open new split on the right
    set autochdir               " Automatically use the current file's directory as the working directory
    set autowrite               " Automatically write a file when leaving a modified buffer 
    set viewoptions=folds,options,cursor,unix,slash " Better unix / windows compatibility
    set virtualedit=onemore     " Allow for cursor beyond last character
    set history=50              " Store last 50 commands in history (default is 20)
    set timeoutlen=500          " Lower the timeout after typing the leader key
    set hidden                  " Switch between buffers without saving
    set visualbell              " No beeping
    set dictionary+=$HOME/.vim/includes/dictionary.txt "Custom autocomplete dictionary

    " ejs in Node.js is kindof like html
    au BufRead,BufNewFile *.ejs set filetype=html

    " strange bug in Ubuntu seems the ft is not set automatically for CS
    au BufRead,BufNewFile *.coffee set filetype=coffee

    autocmd bufwritepost .vimrc source $MYVIMRC " Source the vimrc file after saving it 
    " Load a template from the templates folder - function defined in
    " includes/functions.php
    autocmd BufNewFile * silent! call LoadTemplate('%:e')

    " Save template on exit and then reload it
    " autocmd VimEnter * call LoadSession()
    " autocmd VimLeave * call SaveSession()
    " 
    " Save view on exit and then reload it
    " au BufWinLeave * silent! mkview 
    " au BufWinEnter * silent! loadview

    " Setting up the directories {
        set nobackup                            " No backups
        set nowritebackup                       " and again
        set directory=$HOME/.vim/tmp//,.        " Swap files location
        set viewdir=$HOME/.vim/sessions         " View files location
    " }
" }

" Vim UI {
    colorscheme mustang             " Set the 'theme' - some alternatives would be
                                    " vividchalk, molokai, desert, molokai-modified, synic, blackboard
    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode
    set cursorline                  " CursorLine color group for the current line
    call OverLength()               " 80 column concern trick from includes/functions.vim
    call PopupMenuLikeIDE()         " Completion popup menu like in an IDE from includes/functions.vim

    if has('cmdline_info')
        set ruler                   " show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
        set showcmd                 " show partial commands in status line and
                                    " selected characters/lines in visual mode
    endif 

    if has('statusline')
        set laststatus=2            "Always show the status line

        " Broken down into easily includeable segments
        set statusline=%<%f\                                " Filename
        " set statusline+=\ [%{getcwd()}]                     " Current dir
        set statusline+=%w%h%m%r                            " Options
        set statusline+=%{fugitive#statusline()}            " Git Hotness
        set statusline+=\ [%{&ff}/%Y]                       " Filetype
        " set statusline+=\ [%{strftime(\"%l:%M:%S\ \%p,\ %a\ %b\ %d,\ %Y\")}]\ 
                                                            " Current time
        " set statusline+=\ [A=\%03.3b/H=\%02.2B] " ASCII / Hexadecimal value of char
        set statusline+=[tabs=%{&ts}]
        set statusline+=%=%-14.(line:%l,col:%c%V%)\ %p%%    " Right aligned file nav info
    endif

    "Set a nice title
    set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{v:servername}
    set backspace=indent,eol,start          " Intuitive backspace
    set linespace=3                         " Prefer a slightly higer line height
    set number                              " Show line numbers
    set showmatch                           " Show matching brackets/parenthesis
    set incsearch                           " Find as you type search
    set hlsearch                            " Highlight search terms
    set ignorecase                          " Case-insensitive searching.
    set smartcase                           " But case-sensitive if expression contains a capital letter.
    set wildmenu                            " Show list instead of just completing
    set wildmode=list:longest,full          " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]           " Backspace and cursor keys wrap to
    " set scrolljump=5                      " Lines to scroll when cursor leaves screen
    set scrolloff=5                         " Minimum 5 lines of text above and below the cursor
    set foldenable                          " Auto fold colde
    set gdefault                            " The /g flag on :s substitutions by default
    set list                                " View tabs, where line ends etc
    set listchars=tab:>.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
                                            " Tab displays as >.. & space as .
" }

" Formatting {
    set nowrap                  " Don't wrap long lines
    set smartindent             " Do smart autoindenting when starting a new line
                                " works for C-like programs
    set autoindent              " Indent at the same level of the previous line
    set shiftwidth=2            " Use indents of 4 spaces
    set expandtab               " Tabs are spaces, not tabs
    set tabstop=2               " Number of spaces that a <Tab> in the file counts for
                                " an indentation every 4 columns
    set softtabstop=2           " Let backspace delete indent
    set pastetoggle=<F12>       " Sane indentation on pastes
    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

    " JavaScript & Ruby - set 2 spaces for tabs
    au FileType javascript set shiftwidth=2
    au FileType javascript set tabstop=2
    au FileType javascript set softtabstop=2

    au FileType ruby set shiftwidth=2
    au FileType ruby set tabstop=2
    au FileType ruby set softtabstop=2
" }

" Key (re)Mappings {

    "The default leader is '\', but many people prefer ',' as it's in a standard
    "location
    " let mapleader = ','

    " Making it so ; works like : for commands. 
    " Saves typing and eliminates :W style typos due to lazy holding shift.
    nnoremap ; :

    " Fix for navigating long lines
    " Wrapped lines goes down/up to next row, rather than next line in file.
    map <A-DOWN> gj
    map <A-UP> gk
    imap <A-UP> <ESC>gki
    imap <A-DOWN> <ESC>gji

    " Stupid shift key fixes
    cmap W w
    cmap WQ wq
    cmap wQ wq
    cmap Q q
    cmap Tabe tabe

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    "Shortcut to fold tags with leader (usually \) + ft
    nnoremap <leader>ft Vatzf

    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Map escape to ,e
    imap ,e <esc>

    " Shortcut for editing .vimrc
    nmap ,ev :tabedit $MYVIMRC<cr>

    " Delete all buffers except the current one (via Derek Wyatt)
    nmap <silent> ,da :exec "1," . bufnr('$') . "bd"<cr>

    "Opens a vertical split and switches over (\v)
    nmap <leader>v <C-w>v<C-w>l

    " Jump between placeholders with CTRL+J
    nnoremap <c-j> /<+.\{-1,}+><cr>c/+>/e<cr>
    inoremap <c-j> <ESC>/<+.\{-1,}+><cr>c/+>/e<cr>

    " Toggle highlight search with CTRL+S
    " Function defined in includes/functions.vim
    nmap <silent> <C-s> <Esc>:call ToggleHLSearch()<cr>
" }

" GUI Settings {
   " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=m          " Remove the menu & toolbar
        set guioptions-=T
        set lines=55 columns=158    " Set fullscreen for my desktop
    else
        set term=builtin_ansi       " Make arrow and other keys work
    endif 
" }

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }
