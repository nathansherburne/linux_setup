" Basic Settings ----------------------- {{{
" Jump to the last position when reopening a file.
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif

set foldlevelstart=0
" }}}

" Status Line ----------------------- {{{
set laststatus=2
" }}}

" Mappings ----------------------- {{{
let mapleader = ","
let maplocalleader = "\\"

" Normal "----------------------- {{{
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>_ dd<Up>P
nnoremap <leader>- ddp
nnoremap <BS> <Left><Del>
nnoremap <c-u> mxviwU<esc>`x
nnoremap <leader>" ea"<esc>bi"<esc>lel
nnoremap <leader>' ea'<esc>bi'<esc>lel
nnoremap H 0
nnoremap L $
" }}}

" Insert "----------------------- {{{
inoremap <c-u> <esc>mxviwU<esc>`xa
inoremap <c-d> <esc>ddi
inoremap <BS> <Left><Del>
inoremap jk <esc>
" }}}

" Visual "----------------------- {{{
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>`>l
vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>`>l
vnoremap <Tab> :s/^/	<CR>gv
vnoremap <S-Tab> :s/^	/<CR>gv
" }}}

" Operator-Pending Mappings ----------------------- {{{
onoremap in( :<c-u>normal! f(vi(<CR>
onoremap il( :<c-u>normal! F)vi(<CR>
" }}}

" Disable ----------------------- {{{
"inoremap <Right> <nop>
"inoremap <Up> <nop>
"vnoremap <Left> <nop>
"vnoremap <Right> <nop>
"vnoremap <Up> <nop>
"vnoremap <Left> <nop>
"nnoremap <Left> <nop>
"nnoremap <Right> <nop>
"nnoremap <Up> <nop>
"nnoremap <Left> <nop>
"nnoremap <Down> <nop>
" }}}
" }}}

" Abbreviations ----------------------- {{{
iabbrev @@ sherburne.nathan@gmail.com
" }}}

" Auto Commands ----------------------- {{{
filetype on

" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" HTML ----------------------- {{{
augroup htmlgroup
	autocmd!
	autocmd BufNewFile,BufRead *.html setlocal nowrap
	autocmd FileType html setlocal tabstop=2
	autocmd FileType html setlocal shiftwidth=2
	autocmd FileType html :iabbrev <buffer> <p> <p><CR><CR></p><Up><Tab><C-R>=Eatchar('\m.$')<CR>
	autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END
" }}}

" Python ----------------------- {{{
augroup pygroup
	autocmd!
	autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
	autocmd FileType python nnoremap <buffer> <localleader>sc mxyiw:r !camel_snake -n <C-r>0<CR>yiw`xviwp<Down>dd`x
	"autocmd FileType python onoremap <buffer> ad :<C-u>execute "normal! ?def\rV/def\r"<CR>
	autocmd FileType python setlocal tabstop=4
	autocmd FileType python setlocal shiftwidth=4
	autocmd FileType python setlocal expandtab
	autocmd FileType python :iabbrev <buffer> iff if:<left>
augroup END
" }}}

" JSON ------------------------- {{{
augroup jsongroup
	autocmd!
	autocmd FileType json set tabstop=4
	autocmd FileType json set shiftwidth=4
	autocmd FileType json set expandtab
augroup END
" }}}

" Shell -------------------------------- {{{
augroup shgroup
	autocmd!
	autocmd FileType sh set tabstop=4
	autocmd FileType sh set shiftwidth=4
	autocmd FileType sh set expandtab
augroup END
" }}}

" Javascript ----------------------- {{{
augroup jsgroup
	autocmd!
	autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
augroup END
" }}}
" }}}

" Functions ----------------------- {{{
func! Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc

function! WhichTab(filename)
    " Try to determine whether file is open in any tab.  
    " Return number of tab it's open in
    let buffername = bufname(a:filename)
    if buffername == ""
        return 0
    endif
    let buffernumber = bufnr(buffername)

    " tabdo will loop through pages and leave you on the last one;
    " this is to make sure we don't leave the current page
    let currenttab = tabpagenr()
    let tab_arr = []
    tabdo let tab_arr += tabpagebuflist()

    " return to current page
    exec "tabnext ".currenttab

    " Start checking tab numbers for matches
    let i = 0
    for tnum in tab_arr
        let i += 1
        echo "tnum: ".tnum." buff: ".buffernumber." i: ".i
        if tnum == buffernumber
            return i
        endif
    endfor

endfunction

function! TabEditFile(filename, refresh)
  " Edit a file that may or may not be already open in a tab.
  if WhichTab(a:filename)
    exec "tabnext ".WhichTab(a:filename)
    if a:refresh
      edit!
    endif
  else
    exec "tabedit ".a:filename
  endif
endfunc
" }}}

" Global Marks File ----------------------- {{{
func! PopulateMarksFile()
  split tmpfile_qeicmdvs
  redir! >~/.vim/global_marks.txt
  marks abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
  redir END
  exit
  call TabEditFile('~/.vim/global_marks.txt', 1)
  tabm 0
endfunc

func! DeleteMark(c)
  execute "delm ".a:c
  split ~/.viminfo
  normal gg
  execute "/^# File marks"
  execute "/'".a:c
  normal dddd
  write
  execute "delm ".a:c
  exit
endfunc

nnoremap <leader>m :call PopulateMarksFile()<CR><CR>

augroup globmarksgroup
	autocmd!
	autocmd BufNewFile,BufRead global_marks.txt nnoremap <buffer> <Enter> 04wvg_y:call TabEditFile("<C-r>"", 0)<CR> :tabm<CR>
	autocmd BufNewFile,BufRead global_marks.txt nnoremap <buffer> <localleader>d 0wvy:call DeleteMark("<C-r>0")<CR> :call PopulateMarksFile()<CR><CR>
	autocmd BufNewFile,BufRead global_marks.txt setlocal cursorline
	"autocmd BufNewFile,BufRead global_marks.txt execute "call PopulateMarksFile()"
	autocmd BufNewFile,BufRead global_marks.txt execute "normal ggdd"
	autocmd BufLeave global_marks.txt execute "q!"
augroup END


" }}}
