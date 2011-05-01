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
    set autochdir               " Automatically use the current file's directory as the working directory
    set autowrite               " Automatically write a file when leaving a modified buffer 
    set viewoptions=folds,options,cursor,unix,slash " Better unix / windows compatibility
    set virtualedit=onemore     " Allow for cursor beyond last character
    set history=50              " Store last 50 commands in history (default is 20)

    " Setting up the directories {
        set nobackup                            " No backups
        set nowritebackup                       " and again
        set directory=$HOME/.vim/tmp//,.        " Swap files location
        set viewdir=$HOME/.vim/sessions         " View files location
    " }
" }

" Vim UI {
    colorscheme molokai-modified    " Set the 'theme' - some alternatives would be
                                    " vividchalk, molokai, desert, mustang, synic, blackboard
    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set cursorline                  " CursorLine color group for the current line
    
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
        set statusline+=\ [%{getcwd()}]                     " Current dir
        set statusline+=%w%h%m%r                            " Options
        set statusline+=%{fugitive#statusline()}            " Git Hotness
        set statusline+=\ [%{&ff}/%Y]                       " Filetype
        set statusline+=\ [%{strftime(\"%l:%M:%S\ \%p,\ %a\ %b\ %d,\ %Y\")}]\ 
                                                            " Current time
        "set statusline+=\ [A=\%03.3b/H=\%02.2B] " ASCII / Hexadecimal value of char
        set statusline+=%=%-14.(line:%l,col:%c%V%)\ %p%%    " Right aligned file nav info
    endif

    set backspace=indent,eol,start          " Intuitive backspace
    set linespace=3                         " Prefer a slightly higher line height
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
    set shiftwidth=4            " Use indents of 4 spaces
    set expandtab               " Tabs are spaces, not tabs
    set tabstop=4               " Number of spaces that a <Tab> in the file counts for
                                " an indentation every 4 columns
    set softtabstop=4           " Let backspace delete indent
    set pastetoggle=<F12>       " Sane indentation on pastes
    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
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

"Set a nice title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{v:servername}
set visualbell " No beeping

set timeoutlen=500 " Lower the timeout after typing the leader key

set hidden " Switch between buffers without saving

" Neat trick to highlight the 80th column (Vim 7.3) or highlight columns >80 
" Got this from here: 
" http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('OverLength', '\%>80v.\+', -1)
endif

function ToggleHLSearch()
    if &hls
        set nohls
    else
        set hls
    endif
endfunction
"shortcut CTRL+S for toggle highlight search
nmap <silent> <C-s> <Esc>:call ToggleHLSearch()<cr>

set mousehide "Hide mouse when typing

"Custom autocomplete dictionary
set dictionary+=$HOME/.vim/includes/dictionary.txt "triggered by CTRL+X CTRL+K

set splitbelow  "Splits window BELOW current window

"http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
            \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
            \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


" Source the vimrc file after saving it 
" so you don't have to reload VIM to see the changes
autocmd bufwritepost .vimrc source $MYVIMRC

"PHP stuff
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" First load the template, then load the patterns for that template
function! LoadTemplate(extension)
    silent! :execute '0r $HOME/.vim/templates/'. a:extension. '.tpl'
    silent! :execute '$d'
    silent! execute 'source $HOME/.vim/templates/'.a:extension.'.patterns.tpl'
endfunction
" And to actually call the function, we change autocmd to look like this:
autocmd BufNewFile * silent! call LoadTemplate('%:e')

" Save session on exit and then reload it
"
" function! SaveSession()
"     execute 'mksession! $HOME/.vim/sessions/session.vim'
" endfunction
" function! LoadSession()
"     if argc() == 0
"         execute 'source $HOME/.vim/sessions/session.vim'
"     endif
" endfunction
" autocmd VimEnter * call LoadSession()
" autocmd VimLeave * call SaveSession()
" 
" Save view on exit and then reload it
" au BufWinLeave * silent! mkview 
" au BufWinEnter * silent! loadview

" This file contains all the abbreviations
source $HOME/.vim/includes/abbreviations.vim 

" This file contains all the plugin customizations
source $HOME/.vim/includes/plugin_settings.vim 
