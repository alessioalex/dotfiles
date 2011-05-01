" All plugin customizations should be placed here

let g:EasyMotion_leader_key = '<Leader>e'

"------------------------"
"FUZZYFINDER PLUGIN SETTINGS
"------------------------"
nmap ,f :FufFile<CR>

"------------------------"
"TAGLIST PLUGIN SETTINGS
"------------------------"
nmap ,t :TlistToggle<CR>

"------------------------"
"NERDTREE PLUGIN SETTINGS
"------------------------"
"Shorcut for NERDTreeToggle
nmap ,nt :NERDTreeToggle<CR>

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

" Zen Coding plugin 
" Change zen coding plugin expansion key to ctrl + e
let g:user_zen_expandabbr_key = '<C-e>'

"Faster shortcut for commenting. Requires T-Comment plugin
map <leader>c <c-_><c-_>
