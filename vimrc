call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible                "Forget compatibility with Vi. Who cares.

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

"Turn on syntax highlighting
syntax on

set autowrite "Write the old files when switching to new files

set ruler "Display the cursor position in the right corner

"set mapleader = "," "Want a different mapleader than \

set timeoutlen=500 "Lower the timeout after typing the leader key

set hidden "Switch between buffers without saving

"===== GUI STUFF HERE ====="

"Set the color scheme. Change this to your preference.
"Here's 100 to choose from: http://www.vim.org/scripts/script.php?script_id=625
" colorscheme desert
colorscheme molokai-modified
" colorscheme mustang
" colorscheme vividchalk

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
set autoindent
"Fix the problem for re-selecting the text after visual indentation
vmap > >gv
vmap < <gv

set laststatus=2 "Always show the status line
"Slick trick to show a better statusline
set statusline=%<%t%h%m%r\ \ %a\ %{strftime(\"%c\")}%=0x%B\ \ line:%l,\ \ col:%c%V\ %P
"Ads the fugitive branch to the status line -> %{fugitive#statusline()}

set linespace=3 "Prefer a slightly higher line height

"Better line wrapping
"set wrap
"set textwidth=79
"set formatoptions=qrn1


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

set scrolloff=5 "Minimum 5 lines of text above and below the cursor

"Hard-wrap paragraphs of text
"press \q to format a biiig long line into multiple lines
"nnoremap <leader>q gqip

set mousehide "Hide mouse when typing

set foldenable "Enable code folding
"Shortcut to fold tags with leader (usually \) + ft
nnoremap <leader>ft Vatzf

"Custom autocomplete dictionary
set dictionary+=/home/alessio/.vim/dict.txt "triggered by CTRL+X CTRL+K

"Opens a vertical split and switches over (\v)
nnoremap <leader>v <C-w>v<C-w>l

set splitbelow  "Splits window BELOW current window

"Set up an HTML5 template for all new .html files
"autocmd BufNewFile * silent! 0r $VIMHOME/templates/%e.tpl

"Load the current buffer into Firefox - Ubuntu specific
abbrev ff :! firefox %:p &
"same command for MAC:
"abbrev ff :! open -a firefox.app %:p<cr>

"Map a change directory to the desktop - works on MAC, Ubuntu (Linux)
"nmap ,d :cd ~/Desktop<cr>e.<cr>

"Map a change directory to the PHP www folder
"nmap ,p :cd /var/www<cr>e.<cr> 

"Shortcut for editing .vimrc
nmap ,ev :tabedit $MYVIMRC<cr>

"Change zen coding plugin expansion key to ctrl + e
let g:user_zen_expandabbr_key = '<C-e>'

"Faster shortcut for commenting. Requires T-Comment plugin
map <leader>c <c-_><c-_>

"Save time
"nmap <space> :

"Automatically change current directory to that of the file in the buffer
"autocmd BufEnter * cd %:p:h

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

"Map escape to ,e
imap ,e <esc>

"Delete all buffers (via Derek Wyatt)
nmap <silent> ,da :exec "1," . bufnr('$') . "bd"<cr>

"Source the vimrc file after saving it so you don't have to reload VIM to see
"the changes
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

"Helpeful abbreviations
iab lorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
iab llorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

"Spelling corrects. Just for example. Add yours below.
iab teh the
iab Teh The

"PHP stuff
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

"------------------------"
"TAGLIST PLUGIN SETTINGS
"------------------------"
nmap ,t :TlistToggle

"------------------------"
"NERDTREE PLUGIN SETTINGS
"------------------------"
"Shorcut for NERDTreeToggle
nmap ,nt :NERDTreeToggle

"Show hidden files in NerdTree 
let NERDTreeShowHidden=1

"autopen NERDTree and focus cursor in new document
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

"Closetag plugin
let g:closetag_html_style=1 
"autocmd Filetype html,xml,xsl source ~/.vim/scripts/closetag.vim 

"PDV - Php Documentor stuff
map ,d :call PhpDocSingle()<CR> 
vnoremap ,d :call PhpDocRange()<CR>

" Netrw plugin - FTP
let g:netrw_altv          = 1
let g:netrw_fastbrowse    = 2
let g:netrw_keepdir       = 0
let g:netrw_liststyle     = 2
let g:netrw_retmap        = 1
let g:netrw_silent        = 1
let g:netrw_special_syntax= 1

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
