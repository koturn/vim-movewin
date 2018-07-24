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
  let d1  = 4
  let d2  = 16
  let x   = s:getwinposx()
  let y   = s:getwinposy()
  let key = 'k'
  let title = &titlestring

  if x == -1 || y == -1
    echoerr 'Can not get window position'
    return
  else
    while stridx('hjklHJKL', key) >= 0
      let &titlestring = 'Moving window: (' . x . ', ' . y . ')'
      if &lazyredraw
        redraw
      endif

      let key = nr2char(getchar())
      if key ==? 'h'
        let x = x - d1
        if key ==# 'H'
          let x = x - d2
        endif
      elseif key ==? 'j'
        let y = y + d1
        if key ==# 'J'
          let y = y + d2
        endif
      elseif key ==? 'k'
        let y = y - d1
        if key ==# 'K'
          let y = y - d2
        endif
      elseif key ==? 'l'
        let x = x + d1
        if key ==# 'L'
          let x = x + d2
        endif
      endif
      exec 'winpos ' . x . ' ' . y
    endwhile
  endif

  let &titlestring = title
endfunction


function! s:get_winpos_str()
  let posstr = ''
  redir => posstr
    silent! winpos
  redir END
  let posstr = substitute(posstr, '[\r\n]', '', 'g')
  return split(split(posstr, ':')[1][3 :], ',')
endfunction


if (has('win95') || has('win16') || has('win32') || has('win64'))
      \ && !has('gui_running')
  function! s:getwinposx()
    let s:pos_list = s:get_winpos_str()
    return str2nr(s:pos_list[0])
  endfunction

  function! s:getwinposy()
    let y = str2nr(s:pos_list[1][3 :])
    unlet s:pos_list
    return y
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
  let x = s:getwinposx()
  let y = s:getwinposy()
  if x == -1 || y == -1
    echoerr 'Can not get window position'
  else
    let x = x + a:dist
    exec 'winpos ' . x . ' ' . y
  endif
endfunction

function! movewin#movewin_y(dist)
  let x = s:getwinposx()
  let y = s:getwinposy()
  if x == -1 || y == -1
    echoerr 'Can not get window position'
  else
    let y = y + a:dist
    exec 'winpos ' . x . ' ' . y
  endif
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
