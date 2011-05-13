" All plugin customizations should be placed here {
"
    " CloseTag {
        au FileType * let b:unaryTagsStack=""
        let g:closetag_html_style=1
    " }

    " DelimitMate {
        au FileType * let b:delimitMate_autoclose = 1

        " If using html auto complete (complete closing tag)
        au FileType xml,html,xhtml let b:delimitMate_matchpairs = "(:),[:],{:}"
    " }

    " FuzzyFinder {
        nmap ,f :FufFile<CR>
    " }

    " Matchit {
       call FixMatchitPHP()
    " }

    " NerdTree {
        nmap ,nt :NERDTreeToggle<CR>
        let NERDTreeShowHidden=1

        " Autopen NERDTree and focus cursor in new document
        autocmd VimEnter * NERDTree /var/www
        autocmd VimEnter * wincmd p
    " }

    " Netrw plugin - FTP {
        let g:netrw_altv          = 1
        let g:netrw_fastbrowse    = 2
        let g:netrw_keepdir       = 0
        let g:netrw_liststyle     = 2
        let g:netrw_retmap        = 1
        let g:netrw_silent        = 1
        let g:netrw_special_syntax= 1
    " }

    " PDV - php Documentor {
        map ,d :call PhpDocSingle()<CR> 
        vnoremap ,d :call PhpDocRange()<CR>
    " }

    " phpComplete {
        autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    " }

    " PHP syntax { 
        let php_sql_query=1             " Highlight SQL syntax in strings
        let php_noShortTags = 1         " Disable short tags
        let php_folding = 0             " DON'T enable folding for classes and functions
        let PHP_autoformatcomment = 1
        let php_sync_method = -1
    " }

    " Taglist {
        nmap ,t :TlistToggle<CR>
    " }

    " T-Comment {
        map <leader>c <c-_><c-_>
    " }

    " Zen Coding {
        " Change zen coding plugin expansion key to ctrl + e
        let g:user_zen_expandabbr_key = '<C-e>'
    " }

" }
