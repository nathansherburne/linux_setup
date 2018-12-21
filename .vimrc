" Basic Settings ----------------------- {{{

" Persistent Undo "
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

" Vundle "
source ~/.vim/bundle/Vundle.vim/.vundle_vimrc

""" Format Options """
set formatoptions=tcrn
set autoindent

" Jump to the last position when reopening a file.
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif

""" Colors """
colorscheme evening

" Folding --------------------------- {{{
set foldmethod=marker
set foldlevelstart=0
" }}}

" Status Line ----------------------- {{{
set laststatus=2
set statusline=%f	" Path to file
set statusline+=%=	" Switch to the right side
set statusline+=%l:%c	" Line number: column number
" }}}
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
nnoremap <localleader>rw viw"_dP
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
" When replacing something in visual mode, keep originally yanked text in
" default register. Put replcaed text in black hole register.
xnoremap p "_dP
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
	autocmd FileType python nnoremap <buffer> <localleader>c :call Comment(["#"])<CR>
	autocmd FileType python vnoremap <buffer> <localleader>c :norm \c<CR>
	autocmd FileType python nnoremap <buffer> <localleader>sc mxyiw:r !camel_snake -n <C-r>0<CR>yiw`xviwp<Down>dd`x
	"autocmd FileType python onoremap <buffer> ad :<C-u>execute "normal! ?def\rV/def\r"<CR>
	autocmd FileType python setlocal tabstop=4
	autocmd FileType python setlocal shiftwidth=4
	autocmd FileType python setlocal expandtab
	autocmd FileType python :iabbrev <buffer> iff if:<left>
augroup END
" }}}

" PHP ----------------------- {{{
augroup phpgroup
	autocmd!
	autocmd FileType php nnoremap <buffer> <localleader>sc mxyiw:r !camel_snake -n <C-r>0<CR>yiw`xviwp<Down>dd`x
	autocmd FileType php nnoremap <buffer> <localleader>c I//<esc>
	autocmd FileType php nnoremap <buffer> <localleader>uc ^2x
	autocmd FileType php vnoremap <buffer> <localleader>c :norm \c<CR>
	autocmd FileType php vnoremap <buffer> <localleader>uc :norm \uc<CR>
	autocmd FileType php setlocal tabstop=4
	autocmd FileType php setlocal shiftwidth=4
	autocmd FileType php setlocal expandtab
	autocmd FileType php nnoremap <buffer> <localleader>fh /function<CR>0"sywk"spa/**<CR><ESC>jf(yi(k"spa * @param <ESC>pV:s/, /\r<C-r>s * @param /g<CR>o<ESC>"spa */<ESC>kV?/\*\*<CR>jykp'<:let @l = line(".")<CR>'>:let @k = line(".")<CR>:<C-r>l,<C-r>k!awk 'BEGIN{longest=0}{if (substr($3,1,1) \!= "$" && length($3) > longest) { longest = length($3) }}END{print longest}'<CR>"nyiwddk04w:let @m = col(".") + <C-r>n<CR>V?/\*\*<CR>j:s/ \(\$\w*$\)\@=/              /g<CR>V?/\*\*<CR>j:s/\%<C-r>mc\s*/ <CR>'<:let @l = line(".")<CR>'>:let @k = line(".")<CR>:<C-r>l,<C-r>k!awk '{if (NF == 3) {for ( i = NF + 1; i > 3; i-- ) { $i = $(i-1); } $i = "mixed"; print "<C-r>s " $0;} else {print}}'<CR>
	autocmd FileType php nnoremap <buffer> <localleader>fd o<Tab>public function ()<CR><Tab>{<CR><Tab><CR><Tab>}<Esc>kkk0f(i
	autocmd FileType php nnoremap <buffer> <localleader>il V:s/\d\+/\=(submatch(0)+1)/g<CR>
":<C-r>l,<C-r>k!
	autocmd FileType php nnoremap abc gg/use<CR>V}k:sort<CR>
	autocmd FileType php onoremap iv :<c-u>execute "normal! l?\\$\rvwe"<CR>
	autocmd FileType php onoremap if :<c-u>execute "normal! ?\\/\\*\\*\rV/\/\\*\\*\rk"<CR>
augroup END
" }}}

" YML ----------------------- {{{
augroup yamlgroup
	autocmd!
	autocmd FileType yaml nnoremap <buffer> <localleader>c :call Comment(["#"])<CR>
	autocmd FileType yaml vnoremap <buffer> <localleader>c :norm \c<CR>
	autocmd FileType yaml setlocal tabstop=2
	autocmd FileType yaml setlocal shiftwidth=2
	autocmd FileType yaml setlocal expandtab
augroup END
" }}}

" XML ----------------------- {{{
augroup xmlgroup
	autocmd!
	autocmd FileType xml nnoremap <buffer> <localleader>c :call Comment(["<!--", "-->"])<CR>
	autocmd FileType xml vnoremap <buffer> <localleader>c :norm \c<CR>
	autocmd FileType xml setlocal tabstop=4
	autocmd FileType xml setlocal shiftwidth=4
	autocmd FileType xml setlocal expandtab
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
source ~/.vim/my_functions.vim

func! Comment(commentString)
  let beginComment = a:commentString[0]
  let endComment = ""
  if len(a:commentString) == 2
    let endComment = a:commentString[1]
  endif
  if IsCommented(beginComment)
    execute "s/" . beginComment . "//"
    execute "s/.*\\zs" . endComment . "//"
  else
    let @d = beginComment
    norm! ^
    norm! "dP
    let @d = endComment
    norm! $
    norm! "dp
  endif
endfunc

func! IsCommented(commentString)
  let n = strlen(a:commentString)
  " Go to first char on line
  norm! ^
  for i in range(0, n-1)
    let a = strpart(a:commentString, i, 1)
    norm! yl
    let b = @
    if b != a
      return 0
    endif
    " Go right to next character
    norm! l
  endfor
  return 1
endfunc

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

function! MarkEndsOfPHPVariable()
  norm! yl
  let c = @
  if c == "$"
    " Mark beginning of variable
    norm mb
    " Go to end of variable name
    norm! we
    let inVariable = 1
    while inVariable == 1
      let curc = col(".")
      norm! l
      if curc == col(".")
	" Didn't shift because at end of line.
	let shift = 0
      else
	let shift = 1
      endif
      norm! yl
      let c = @
      if c == "-"
	" Accessor, go to end of next word.
        norm! we
      elseif c == "(" || c == "["
	" Brackets, go to matching.
	" For function calls or arrays.
	norm! %
      else
        " End of variable
	let inVariable = 0
	" Mark last position of variable
	if shift == 1
          norm! h
        endif
	norm! me
      endif
    endwhile
  else
    " Not a variable, delete marks.
    norm! `b
    delm be
  endif
endfunc

function! FindNextStringConcatInclusive()
  norm! yl
  let c = @
  if c == "."
    norm! l
    norm! yl
    let c = @
    if c == "$" || c == "'" || c == "\""
      " On concat already, don't search.
      norm! h
    else
      silent! execute "normal! /\\.[\$'\"]\r"
    endif
  else
    silent! execute "normal! /\\.[\$'\"]\r"
  endif

endfunc

function! FindNextStringConcatInclusiveNotException()
  let prvl = 0
  let curl = line(".")
  let prvc = 0
  let curc = col(".")
  call FindNextStringConcatInclusive()

  while IsInException() && (curl > prvl || curl == prvl && curc > prvc)
    norm! l
    call FindNextStringConcatInclusive()
    let prvl = curl
    let curl = line(".")
    let prvc = curc
    let curc = col(".")
  endwhile
endfunc

function! EscapeDoubleQuotes()
  let curl = line(".")
  norm! yl
  let c = @
  if c == "'"
    norm! mb
    " Find all double quotes in between this single quote and its pair.
    silent! execute "normal! /\\(\\\\\\)\\@<!'\r"
    let endc = col(".")
    norm! `b

    " Find non-escaped double quote.
    let prvc = col(".")
    silent! execute "normal! /\\(\\\\\\)\\@<!\"\r"
    let curc = col(".")

    while col(".") < endc && curc > prvc && line(".") == curl
      norm! i\
      silent! execute "normal! /\\(\\\\\\)\\@<!\"\r"
      let prvc = curc
      let curc = col(".")
    endwhile

    " End on closing single quote.
    norm! `b
    silent! execute "normal! /\\(\\\\\\)\\@<!'\r"
  endif
endfunc

function! IsInException()
  norm! mx
  let curc = col(".")
  let curl = line(".")
  silent! execute "normal! ?Exception\r"
  if curc == col(".") && curl == line(".")
    return 0
  end
  silent! execute "normal! /(\r"
  let openc = col(".")
  let openl = line(".")
  norm! %
  let closec = col(".")
  let closel = line(".")
  if !(curl > closel || curl < openl || (curc > closec && curl == closel) || (curc < openc && curl == openl))
    " In paren
    norm! `x
    return 1
  else
    norm! `x
    return 0
  endif
endfunc

function! UpdatePHPConcat()
  let eset = 0
  norm! gg
  let prvl = line(".")
  call FindNextStringConcatInclusiveNotException()
  let curl = line(".")
  while curl > prvl
    let prvc = 0
    let curc = col(".")
    " Add outer quotes
    let i = 0
    while line(".") == curl && curc > prvc
      " Check left side
      norm! mx
      norm! h
      norm! yl
      let c = @
      if c == "'" || c == "\""
	" Delete surrounding ' or " for strings
	if i == 0
          if c == "'"
            " Find its pair (excludes \')
	    " \ is triple escaped, everything else double.
	    silent! execute "normal! ?\\(\\\\\\)\\@<!'\r"
	    call EscapeDoubleQuotes()
	    norm! `b
          else
            " Find its pair (excludes \")
	    silent! execute "normal! ?\\(\\\\\\)\\@<!\"\r"
          endif
	  norm! x
	  norm! i"
        endif
        call FindNextStringConcatInclusiveNotException()
	norm! hx
      elseif c == "}"
        " Variable already taken care of
	" Go back to dot
	norm! l
      else
	" Assume variable or unknown, try to find $
	norm! lbh
        norm! yl
        let c = @
	if c == "$"
	  if i == 0
	    norm! i"
	    norm! l
          endif
          call MarkEndsOfPHPVariable()
	  norm! `ea}
	  norm! `bi{
        else
	  " Unknown case.
          call FindNextStringConcatInclusiveNotException()
	  return
        endif
      endif
      " Go back to '.'
      call FindNextStringConcatInclusiveNotException()
      norm! mx
      " Check right side
      norm! l
      norm! yl
      let c = @
      if c == "'" || c == "\""
	" Delete surrounding ' or " for strings
        if c == "'"
          " Find its pair (excludes \')
	  " \ is triple escaped, everything else double.
	  call EscapeDoubleQuotes()
	  norm! `b
	  norm! x
	  silent! execute "normal! /\\(\\\\\\)\\@<!'\r"
        else
          " Find its pair (excludes \")
	  norm! x
	  silent! execute "normal! /\\(\\\\\\)\\@<!\"\r"
        endif
	" Delete quote only if not join by dot.
	" Since dot will delete left side next.
        norm! l
        norm! yl
        let c = @
	if c != "."
	  norm! hx
	  norm! hhme
          let eset = 1
        endif
	" Go back to '.'
	norm! `x
      else
	" Assume variable, go right onto $
        norm! yl
        let c = @
        if c == "$"
          call MarkEndsOfPHPVariable()
	  norm! `ea}
	  norm! me
          let eset = 1
        endif
        " Go back to '.'
	norm! `bi{
        norm! h
      endif
      " Delete '.'
      norm! x
      let prvc = col(".")
      call FindNextStringConcatInclusiveNotException()
      let curc = col(".")
      let i = i + 1
    endwhile

    let prvl = curl
    let curl = line(".")
    if curl > prvl
      norm! `ea"
      call FindNextStringConcatInclusiveNotException()
    endif
  endwhile
  
  if eset == 1
    norm! `ea"
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
  if @% == $HOME.'.vim/global_marks.txt'
    call edit!
  else
    call TabEditFile('~/.vim/global_marks.txt', 1)
  endif
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
	"autocmd BufLeave global_marks.txt execute "q!"
augroup END


" }}}

" Vim + Tmux ---------------------------- {{{
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-p> :TmuxNavigatePrevious<cr>
" }}}
