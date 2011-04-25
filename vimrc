call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible "Forget compatibility with Vi. Who cares.

"Set a nice title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{v:servername}
set visualbell " No beeping

set nobackup " Don't make a backup before overwriting a file.
set nowritebackup " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

"Enable file type detection
filetype on
filetype plugin on
filetype indent on

syntax on " Turn on syntax highlighting

set autowrite " Automatically write a file when leaving a modified buffer 

set ruler " Display the cursor position in the right corner

"set mapleader = "," " Want a different mapleader than \

set timeoutlen=500 " Lower the timeout after typing the leader key

set hidden " Switch between buffers without saving

"===== GUI STUFF HERE ====="

" Set the color scheme. Change this to your preference.
" Here's 100 to choose from: http://www.vim.org/scripts/script.php?script_id=625
" colorscheme desert, mustang, vividchalk are other nice options
colorscheme molokai-modified

"set guifont=Lucida_Console:h11:cANSI<CR> "Set font type and size
set guioptions-=m "remove menu bar
set guioptions-=T "remove toolbar
"Open GVim in fullscreen
set lines=55 columns=158
"===== END GUI SETS ====="

set shiftwidth=4
set softtabstop=4
set expandtab

set showcmd "Show command in bottom right position of the screen
set showmode "Show current mode

set number "Show line numbers
"set relativenumber "Prefer relative line numbering?

set backspace=indent,eol,start "Intuitive backspace

"Indent stuff
set smartindent
" autoident = indent new lines by a similar amount to the one next to them
set autoindent 
"Fix the problem for re-selecting the text after visual indentation
vmap > >gv
vmap < <gv

set laststatus=2 "Always show the status line
"Slick trick to show a better statusline
set statusline=%<%t%h%m%r\ \ %a\ %{strftime(\"%c\")}%=0x%B\ \ line:%l,\ \ col:%c%V\ %P
"Ads the fugitive branch to the status line -> %{fugitive#statusline()}

set linespace=3 "Prefer a slightly higher line height

set ignorecase "Case-insensitive searching.
set smartcase  "But case-sensitive if expression contains a capital letter.
set incsearch "Set incremental searching
set hlsearch "Highlight search

" Neat trick to highlight the 80th column (Vim 7.3) or highlight columns >80 
" Got this from here: 
" http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns
if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
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

set cursorline " CursorLine color group for the current line
set scrolloff=5 " Minimum 5 lines of text above and below the cursor

set mousehide "Hide mouse when typing

set foldenable "Enable code folding
"Shortcut to fold tags with leader (usually \) + ft
nnoremap <leader>ft Vatzf

"Custom autocomplete dictionary
set dictionary+=$HOME/.vim/includes/dictionary.txt "triggered by CTRL+X CTRL+K

"Opens a vertical split and switches over (\v)
nnoremap <leader>v <C-w>v<C-w>l

set splitbelow  "Splits window BELOW current window

"Shortcut for editing .vimrc
nmap ,ev :tabedit $MYVIMRC<cr>

"Automatically use the current file's directory as the working directory
set autochdir

"Map code completion to ,tab
imap ,<tab> <C-x><C-o>

set wildmenu "Enhanced command line completion.
"At command line, complete longest common string, then list alternatives
set wildmode=list:longest

"http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
            \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
            \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Map escape to ,e
imap ,e <esc>

" Delete all buffers except the current one (via Derek Wyatt)
nmap <silent> ,da :exec "1," . bufnr('$') . "bd"<cr>

" Fix for navigating long lines
map <A-DOWN> gj
map <A-UP> gk
imap <A-UP> <ESC>gki
imap <A-DOWN> <ESC>gji

" Source the vimrc file after saving it 
" so you don't have to reload VIM to see the changes
autocmd bufwritepost .vimrc source $MYVIMRC

" Tab mappings.
" map <leader>tt :tabnew<cr>
" map <leader>te :tabedit
" map <leader>tc :tabclose<cr>
" map <leader>to :tabonly<cr>
" map <leader>tn :tabnext<cr>
" map <leader>tp :tabprevious<cr>
" map <leader>tf :tabfirst<cr>
" map <leader>tl :tablast<cr>
" map <leader>tm :tabmove

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
" Jump between placeholders with CTRL+J
nnoremap <c-j> /<+.\{-1,}+><cr>c/+>/e<cr>
inoremap <c-j> <ESC>/<+.\{-1,}+><cr>c/+>/e<cr>

" Neat trick to keep the current session on exit
" " Uncomment if you want to use it
" autocmd VimEnter * call LoadSession()
" autocmd VimLeave * call SaveSession()
" function! SaveSession()
"     execute 'mksession! $HOME/.vim/sessions/session.vim'
" endfunction
" function! LoadSession()
"     if argc() == 0
"         execute 'source $HOME/.vim/sessions/session.vim'
"     endif
" endfunction

" This file contains all the abbreviations
source $HOME/.vim/includes/abbreviations.vim 

" This file contains all the plugin customizations
source $HOME/.vim/includes/plugin_settings.vim 
