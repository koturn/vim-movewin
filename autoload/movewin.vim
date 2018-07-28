"=============================================================================
" FILE: movewin.vim
" AUTHOR: koturn <jeak.koutan.apple@gmail.com>
" DESCRIPTION: {{{
" This Vim plugin was forked from
"   http://www.vim.org/scripts/script.php?script_id=741
" The original plugin could be used in GUI only. But this forked plugin can be
" used in Windows-CUI (Command-Prompt) also.
" }}}
"=============================================================================
let s:save_cpo = &cpo
set cpo&vim


function! movewin#movewin() abort " {{{
  let [x, y] = s:getwinposxy()
  if x == -1 || y == -1
    echoerr 'Can not get window position'
    return
  endif
  let [old_titlestring, &titlestring] = [&titlestring, 'Moving window: (' . x . ', ' . y . ')']
  redraw
  let [cmd_dict, key] = [s:build_cmd_dict('x', 'y', 4, 20), nr2char(getchar())]
  while has_key(cmd_dict, key)
    let [x, y] = s:getwinposxy()
    execute cmd_dict[key]
    execute 'winpos' x y
    let [&titlestring, key] = ['Moving window: (' . x . ', ' . y . ')', nr2char(getchar())]
    redraw
  endwhile
  let &titlestring = old_titlestring
endfunction " }}}

function! movewin#movewin_x(dist) abort " {{{
  let [x, y] = s:getwinposxy()
  if x == -1 || y == -1
    echoerr 'Can not get window position'
  else
    let x = x + a:dist
    execute 'winpos' x y
  endif
endfunction " }}}

function! movewin#movewin_y(dist) abort " {{{
  let [x, y] = s:getwinposxy()
  if x == -1 || y == -1
    echoerr 'Can not get window position'
  else
    let y = y + a:dist
    execute 'winpos' x y
  endif
endfunction " }}}


function! s:build_cmd_dict(name_x, name_y, dist1, dist2) abort " {{{
  return {
        \ 'h': printf('let %s -= %d', a:name_x, a:dist1),
        \ 'j': printf('let %s += %d', a:name_y, a:dist1),
        \ 'k': printf('let %s -= %d', a:name_y, a:dist1),
        \ 'l': printf('let %s += %d', a:name_x, a:dist1),
        \ 'H': printf('let %s -= %d', a:name_x, a:dist2),
        \ 'J': printf('let %s += %d', a:name_y, a:dist2),
        \ 'K': printf('let %s -= %d', a:name_y, a:dist2),
        \ 'L': printf('let %s += %d', a:name_x, a:dist2)
        \}
endfunction " }}}

if (has('win95') || has('win16') || has('win32') || has('win64')) && !has('gui_running')
  function! s:getwinposxy() abort " {{{
    redir => posstr
      silent! winpos
    redir END
    let xypospair = split(split(substitute(posstr, '[\r\n]', '', 'g'), ':')[1][3 :], ',')
    return [str2nr(xypospair[0]), str2nr(xypospair[1][3 :])]
  endfunction " }}}
else
  function! s:getwinposxy() abort " {{{
    return [getwinposx(), getwinposy()]
  endfunction " }}}
endif


let &cpo = s:save_cpo
unlet s:save_cpo
