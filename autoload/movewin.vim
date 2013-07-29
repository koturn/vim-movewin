"=============================================================================
" FILE: movewin.vim
" AUTHOR: koturn <jeak.koutan.apple@gmail.com>
" Last Modified: 17 July 2013.
" DESCRIPTION: {{{
" This Vim plugin was forked from
"   http://www.vim.org/scripts/script.php?script_id=741
" The original plugin could be used in GUI only. But this forked plugin can be
" used in Windows-CUI (Command-Prompt) also.
" }}}
"=============================================================================
let s:save_cpo = &cpo
set cpo&vim


function! movewin#movewin()
  let l:d1  = 4
  let l:d2  = 16
  let l:x   = s:getwinposx()
  let l:y   = s:getwinposy()
  let l:key = 'k'
  let l:title = &titlestring

  if l:x == -1 || l:y == -1
    echoerr 'Can not get window position'
    return
  else
    while stridx('hjklHJKL', l:key) >= 0
      let &titlestring = 'Moving window: (' . l:x . ', ' . l:y . ')'
      if &lazyredraw
        redraw
      endif

      let l:key = nr2char(getchar())
      if l:key ==? 'h'
        let l:x = l:x - l:d1
        if l:key ==# 'H'
          let l:x = l:x - l:d2
        endif
      endif
      if l:key ==? 'j'
        let l:y = l:y + l:d1
        if l:key ==# 'J'
          let l:y = l:y + l:d2
        endif
      endif
      if l:key ==? 'k'
        let l:y = l:y - l:d1
        if l:key ==# 'K'
          let l:y = l:y - l:d2
        endif
      endif
      if l:key ==? 'l'
        let l:x = l:x + l:d1
        if l:key ==# 'L'
          let l:x = l:x + l:d2
        endif
      endif
      exec 'winpos ' . l:x . ' ' . l:y
    endwhile
  endif

  let &titlestring = l:title
endfunction


function! s:get_winpos_str()
  let l:posstr = ''
  redir => l:posstr
    silent! winpos
  redir END
  let l:posstr = substitute(l:posstr, '[\r\n]', '', 'g')
  return split(split(l:posstr, ':')[1][3 :], ',')
endfunction


if (has('win95') || has('win16') || has('win32') || has('win64'))
      \ && !has('gui_running')
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


function! movewin#movewin_x(dist)
  let l:x = s:getwinposx()
  let l:y = s:getwinposy()
  if l:x == -1 || l:y == -1
    echoerr 'Can not get window position'
  else
    let l:x = l:x + a:dist
    exec 'winpos ' . l:x . ' ' . l:y
  endif
endfunction

function! movewin#movewin_y(dist)
  let l:x = s:getwinposx()
  let l:y = s:getwinposy()
  if l:x == -1 || l:y == -1
    echoerr 'Can not get window position'
  else
    let l:y = l:y + a:dist
    exec 'winpos ' . l:x . ' ' . l:y
  endif
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
