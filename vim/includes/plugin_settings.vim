" All plugin customizations should be placed here {

    " FuzzyFinder {
        nmap ,f :FufFile<CR>
    " }

    " Taglist {
        nmap ,t :TlistToggle<CR>
    " }

    " NerdTree {
        nmap ,nt :NERDTreeToggle<CR>
        let NERDTreeShowHidden=1

        " Autopen NERDTree and focus cursor in new document
        autocmd VimEnter * NERDTree
        autocmd VimEnter * wincmd p
    " }


    " Closetag plugin {
        let g:closetag_html_style=1 
        " autocmd Filetype html,xml,xsl source ~/.vim/scripts/closetag.vim 
    " }

    " PDV - php Documentor {
        map ,d :call PhpDocSingle()<CR> 
        vnoremap ,d :call PhpDocRange()<CR>
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

    " Zen Coding {
        " Change zen coding plugin expansion key to ctrl + e
        let g:user_zen_expandabbr_key = '<C-e>'
    " }

    " T-Comment {
        map <leader>c <c-_><c-_>
    " }

" }
