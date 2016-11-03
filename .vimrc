execute pathogen#infect()
" Basic config
    if &diff
        syntax off
        set diffopt=filler,context:2
        set diffopt+=iwhite
    else
        syntax on
    endif
    filetype indent plugin on
    set relativenumber
    set paste
    set tabstop=8 expandtab shiftwidth=4 softtabstop=4
    set vb t_vb=    " No bell
    " Mouse config
        let g:mousemode = "nvh" " Default mouse mode
        " let g:mousemode = "nvh" " Default mouse mode
        " let &mouse=

" Statusline
    set laststatus=2
    " Left side
        set statusline=[%n]%.35F%m[%{&ro?'RO':'RW'}]%h%w
        set statusline+=[%{&ff},%{strlen(&fenc)?&fenc:'none'}]
        set statusline+=%y
    " Right side
        set statusline+=%=%4v:%l\ %4{strlen(getline(\".\"))}:%L 

"folding settings
    set foldmethod=indent   "fold based on indent
    set foldnestmax=3      "deepest fold is 10 levels
    set nofoldenable        "dont fold by default
    set foldlevel=0         "this is just what i use
    :map za zA

" General maps
    " nnoremap <C-v> :set ro!<CR>echo<CR>
    map <C-b> gc
    map <C-c><C-c> :so %<CR>
    nnoremap <PageUp> <C-u>
    nnoremap <PageDown> <C-d>
    map <C-y> yygccp
    map <C-Down> <C-d>

" Filetypes
    " Theme
        autocmd BufEnter * colorscheme elflord
        " autocmd BufEnter *.py colorscheme py-darcula
" Reverting
    map <C-r><C-r><C-r> :Restore<CR><CR>
    map <C-r><C-r> :Revert<CR><CR>
    map <C-r><C-d> :DiffSaved<CR>
    " map <C-r><C-d><C-d> :DiffStart<CR>
    command! Revert :e!
    command! Restore :u|u1
" Mouse
    nnoremap <C-m> :call MouseToggle()<cr>
    function! MouseToggle()
        if &mouse != ""
            " disable mouse
            let g:mousemode=&mouse
            set mouse=
            echo "Mouse off"
        else
            " enable mouse everywhere
            let &mouse=g:mousemode
            echo "Mouse on"
        endif
    endfunc
" Numbers
    map <C-n>r :set relativenumber!<cr>
    map <C-n>l :set number!<cr>
    map <C-n>n :set nonumber<cr>:set norelativenumber<cr>
    nnoremap <C-n>o :set number<cr>:set relativenumber<cr>
    nnoremap <C-n> :call NumberToggle()<cr>
    function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
        set nonumber
    endif
    endfunc
" Syntax
    nnoremap <C-h> :call SyntaxToggle()<cr>
    function! SyntaxToggle()
        if exists("g:syntax_on") 
            syntax off  
        else
            syntax enable 
        endif
    endfunc
" Folding
    function! FoldToggle()
        if(&foldenable == 1)
            set nofoldenable
            set foldcolumn=0
        else
            set foldcolumn=1
            set foldenable
        endif
    endfunc
    nnoremap <C-f> :call FoldToggle()<cr>
" Diff
    " Saved
        function! s:DiffWithSaved()
          let filetype=&ft
          diffthis
          vnew | r # | normal! 1Gdd
          diffthis
          exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
        endfunction
        com! DiffSaved call s:DiffWithSaved()
    " From start
        function! s:DiffWithStart()
          let filetype=&ft
          diffthis
          vnew | buffer # | normal! 1Gdd
          diffthis
          exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
        endfunction
        com! DiffStart call s:DiffWithStart()

