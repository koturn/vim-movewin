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


command! MoveWin       call movewin#movewin()
command! MoveWinLeft   call movewin#movewin_x(-20)
command! MoveWinDown   call movewin#movewin_y(20)
command! MoveWinUp     call movewin#movewin_y(-20)
command! MoveWinRight  call movewin#movewin_x(20)
noremap  <silent> <Plug>(movewin-left)   :<C-u>MoveWinLeft<CR>
noremap! <silent> <Plug>(movewin-left)   <Esc>:MoveWinLeft<CR>
noremap  <silent> <Plug>(movewin-down)   :<C-u>MoveWinDown<CR>
noremap! <silent> <Plug>(movewin-down)   <Esc>:MoveWinDown<CR>
noremap  <silent> <Plug>(movewin-up)     :<C-u>MoveWinUp<CR>
noremap! <silent> <Plug>(movewin-up)     <Esc>:MoveWinUp<CR>
noremap  <silent> <Plug>(movewin-right)  :<C-u>MoveWinRight<CR>
noremap! <silent> <Plug>(movewin-right)  <Esc>:MoveWinRight<CR>


let &cpo = s:save_cpo
unlet s:save_cpo
