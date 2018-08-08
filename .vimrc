""" Mappings """
let mapleader = ","
let maplocalleader = "\\"

" Normal Mode "
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

" Insert Mode "
inoremap <c-u> <esc>mxviwU<esc>`xa
inoremap <c-d> <esc>ddi
inoremap <BS> <Left><Del>
inoremap jk <esc>

" Visual Mode "
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>`>l
vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>`>l
vnoremap <Tab> :s/^/	<CR>gv
vnoremap <S-Tab> :s/^	/<CR>gv

""" Operator-Pending Mappings """
onoremap in( :<c-u>normal! f(vi(<CR>
onoremap il( :<c-u>normal! F)vi(<CR>

" Disabled "
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

""" Abbreviations """
iabbrev @@ sherburne.nathan@gmail.com

""" Auto Commands """
filetype on

" HTML "
augroup htmlgroup
	autocmd!
	autocmd BufNewFile,BufRead *.html setlocal nowrap
	autocmd FileType html setlocal tabstop=2
	autocmd FileType html setlocal shiftwidth=2
	autocmd FileType html :iabbrev <buffer> <p> <p><CR><CR></p><Up><Tab><C-R>=Eatchar('\m.$')<CR>
	autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END

" Python "
augroup pygroup
	autocmd!
	autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
	autocmd FileType python setlocal tabstop=4
	autocmd FileType python setlocal shiftwidth=4
	autocmd FileType python setlocal expandtab
	autocmd FileType python :iabbrev <buffer> iff if:<left>
augroup END

" Javascript "
augroup jsgroup
	autocmd!
	autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
augroup END

""" Functions """
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

""" Global Marks File """
func! PopulateMarksFile()
  split tmpfile_qeicmdvs
  redir! >~/.vim/global_marks.txt
  marks abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
  redir END
  quit
  call TabEditFile('~/.vim/global_marks.txt', 1)
  tabm 0
  normal ggdd
endfunc

nnoremap <leader>m :call PopulateMarksFile()<CR><CR>

augroup globmarksgroup
	autocmd!
	autocmd BufNewFile,BufRead global_marks.txt nnoremap <buffer> <Enter> 04wvg_y:call TabEditFile("<C-r>"", 0)<CR> :tabm<CR>
	autocmd BufNewFile,BufRead global_marks.txt nnoremap <buffer> <localleader>d 0wvy:delm <C-r>0<CR> :call PopulateMarksFile()<CR><CR>
	autocmd BufNewFile,BufRead global_marks.txt setlocal cursorline
augroup END


