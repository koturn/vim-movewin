"=============================================================================
" FILE: movewin.vim
" AUTHOR: koturn <jeak.koutan.apple@gmail.com>
" Last Modified: 16 July 2013.
" DESCRIPTION: {{{
" This Vim plugin was forked from
"   http://www.vim.org/scripts/script.php?script_id=741
" The original plugin could be used in GUI only. But this forked plugin can be
" used in Windows-CUI (Command-Prompt) also.
" }}}
"=============================================================================

let s:save_cpo = &cpo
set cpo&vim


function! s:movewin()
  let l:d1 = 4
  let l:d2 = 16
  let l:t  = &titlestring
  let l:x  = s:getwinposx()
  let l:y  = s:getwinposy()
  let l:k  = 'k'

  if l:x == -1 || l:y == -1
    echoerr 'Can not get window position'
  else
    while stridx('hjklHJKL', l:k) >= 0
      let &titlestring = 'Moving window: (' . l:x . ', ' . l:y . ')'
      if &lazyredraw
        redraw
      endif

      let l:k = nr2char(getchar())
      if l:k ==? 'h'
        let l:x = l:x - l:d1
        if l:k ==# 'h'
          let l:x = l:x - l:d2
        endif
      endif
      if l:k ==? 'j'
        let l:y = l:y + l:d1
        if l:k ==# 'j'
          let l:y = l:y + l:d2
        endif
      endif
      if l:k ==? 'k'
        let l:y = l:y - l:d1
        if l:k ==# 'k'
          let l:y = l:y - l:d2
        endif
      endif
      if l:k ==? 'l'
        let l:x = l:x + l:d1
        if l:k ==# 'l'
          let l:x = l:x + l:d2
        endif
      endif
      exec 'winpos ' . l:x . ' ' . l:y
    endwhile
  endif

  let &titlestring = l:t
endfunction


function! s:get_winpos_str()
  let l:posstr = ''
  redir => l:posstr
    silent! winpos
  redir END
  let l:posstr = substitute(l:posstr, '[\r\n]', '', 'g')
  return split(split(l:posstr, ':')[1][3 :], ',')
endfunction


if !has('gui_running') || has('win95')
      \ || has('win16') || has('win32') || has('win64')
  function! s:getwinposx()
    let s:pos_list = s:get_winpos_str()
    return str2nr(s:pos_list[0])
  endfunction

  function! s:getwinposy()
    let l:y = str2nr(s:pos_list[1][3 :])
    unlet s:pos_list
    return l:y
  endfunction
else
  function! s:getwinposx()
    return getwinposx()
  endfunction

  function! s:getwinposy()
    return getwinposy()
  endfunction
endif


function! s:movewin_left()
  let l:x = s:getwinposx()
  let l:y = s:getwinposy()
  if l:x == -1 || l:y == -1
    echoerr 'Can not get window position'
  else
    let l:x = l:x - 20
    exec 'winpos ' . l:x . ' ' . l:y
  endif
endfunction

function! s:movewin_down()
  let l:x = s:getwinposx()
  let l:y = s:getwinposy()
  if l:x == -1 || l:y == -1
    echoerr 'Can not get window position'
  else
    let l:y = l:y + 20
    exec 'winpos ' . l:x . ' ' . l:y
  endif
endfunction

function! s:movewin_up()
  let l:x = s:getwinposx()
  let l:y = s:getwinposy()
  if l:x == -1 || l:y == -1
    echoerr 'Can not get window position'
  else
    let l:y = l:y - 20
    exec 'winpos ' . l:x . ' ' . l:y
  endif
endfunction

function! s:movewin_right()
  let l:x = s:getwinposx()
  let l:y = s:getwinposy()
  if l:x == -1 || l:y == -1
    echoerr 'Can not get window position'
  else
    let l:x = l:x + 20
    exec 'winpos ' . l:x . ' ' . l:y
  endif
endfunction


command! MoveWin       call s:movewin()
command! MoveWinLeft   call s:movewin_left()
command! MoveWinDown   call s:movewin_down()
command! MoveWinUp     call s:movewin_up()
command! MoveWinRight  call s:movewin_right()
nnoremap <silent> <Plug>(movewin-left)   :<C-u>MoveWinLeft<CR>
nnoremap <silent> <Plug>(movewin-down)   :<C-u>MoveWinDown<CR>
nnoremap <silent> <Plug>(movewin-up)     :<C-u>MoveWinUp<CR>
nnoremap <silent> <Plug>(movewin-right)  :<C-u>MoveWinRight<CR>


let &cpo = s:save_cpo
unlet s:save_cpo
