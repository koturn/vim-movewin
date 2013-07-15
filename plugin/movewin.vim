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


command! MoveWin       call movewin#movewin()
command! MoveWinLeft   call movewin#movewin_left()
command! MoveWinDown   call movewin#movewin_down()
command! MoveWinUp     call movewin#movewin_up()
command! MoveWinRight  call movewin#movewin_right()
nnoremap <silent> <Plug>(movewin-left)   :<C-u>MoveWinLeft<CR>
nnoremap <silent> <Plug>(movewin-down)   :<C-u>MoveWinDown<CR>
nnoremap <silent> <Plug>(movewin-up)     :<C-u>MoveWinUp<CR>
nnoremap <silent> <Plug>(movewin-right)  :<C-u>MoveWinRight<CR>


let &cpo = s:save_cpo
unlet s:save_cpo
