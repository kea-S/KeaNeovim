-- honestly not too confident with whatever is going on here so ill leave it ugly
vim.cmd([[
function! s:TermEnter(_)
  if getbufvar(bufnr(), 'term_insert', 0)
    startinsert
    call setbufvar(bufnr(), 'term_insert', 0)
  endif
endfunction

function! <SID>TermExec(cmd)
  let b:term_insert = 1
  execute a:cmd
endfunction

augroup Term
  autocmd CmdlineLeave,WinEnter,BufWinEnter * call timer_start(0, function('s:TermEnter'), {})
augroup end

if has('nvim')
  tnoremap <A-;> <C-\><C-n>
  tnoremap <silent> <C-W><C-W>  <cmd>call <SID>TermExec('wincmd w')<CR>
  tnoremap <silent> <C-W>h      <cmd>call <SID>TermExec('wincmd h')<CR>
  tnoremap <silent> <C-W>j      <cmd>call <SID>TermExec('wincmd j')<CR>
  tnoremap <silent> <C-W>k      <cmd>call <SID>TermExec('wincmd k')<CR>
  tnoremap <silent> <C-W>l      <cmd>call <SID>TermExec('wincmd l')<CR>
  tnoremap <silent> <C-W><C-H>  <cmd>call <SID>TermExec('wincmd h')<CR>
  tnoremap <silent> <C-W><C-J>  <cmd>call <SID>TermExec('wincmd j')<CR>
  tnoremap <silent> <C-W><C-K>  <cmd>call <SID>TermExec('wincmd k')<CR>
  tnoremap <silent> <C-W><C-L>  <cmd>call <SID>TermExec('wincmd l')<CR>


  cabbrev ter <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? '10split term://bash' : 'term')<CR>
  cabbrev vter <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vsplit term://bash' : 'vterm')<CR>
  augroup term_cmds
  autocmd!
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd TermEnter term://* setlocal nonu nornu
  autocmd TermLeave term://* setlocal nu rnu
  autocmd TermClose term://* close
  augroup END
  augroup Term
  autocmd!
  autocmd TermClose * ++nested stopinsert | au Term TermEnter <buffer> stopinsert
  augroup end
else
  tnoremap <A-;> <C-w><S-n>
  cnoreabbrev vterm vert term
  endif

  ]])
