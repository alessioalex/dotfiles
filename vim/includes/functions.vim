" My custom tips & tricks function library {

    " Neat trick to highlight the 80th column (Vim 7.3) or highlight columns >80 
    " Got this from here: 
    " http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns
    function! OverLength()
        highlight OverLength ctermbg=red ctermfg=white guibg=#592929
        if exists('+colorcolumn')
            set colorcolumn=80
        else
            au BufWinEnter * let w:m2=matchadd('OverLength', '\%>80v.\+', -1)
        endif
    endfunction

    " Toggle highlight search
    function! ToggleHLSearch()
        if &hls
            set nohls
        else
            set hls
        endif
    endfunction

    "http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
    function! PopupMenuLikeIDE()
        if exists('+insert_expand')
            set completeopt=longest,menuone
            inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
            inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
                        \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
            inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
                        \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
        endif
    endfunction

    " First load the template, then load the patterns for that template
    function! LoadTemplate(extension)
        silent! :execute '0r $HOME/.vim/templates/'. a:extension. '.tpl'
        silent! :execute '$d'
        silent! execute 'source $HOME/.vim/templates/'.a:extension.'.patterns.tpl'
    endfunction

    " Save session on exit and then reload it
    function! SaveSession()
        execute 'mksession! $HOME/.vim/sessions/session.vim'
    endfunction
    function! LoadSession()
        if argc() == 0
            execute 'source $HOME/.vim/sessions/session.vim'
        endif
    endfunction

" }
