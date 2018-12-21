function! GetFunctionOrClassString(s)
	let first_letter = strpart(a:s, 0, 1)
	if first_letter == toupper(first_letter)
		return "class ".a:s
	else
		return "def ".a:s
	endif
endfunction
