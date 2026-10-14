" =============================================================================
" fzf.vim - fzf 設定
" =============================================================================

" -----------------------------------------------------------------------------
" アクション
" -----------------------------------------------------------------------------
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
  copen
  cc
endfunction

function! s:copy_path(lines)
  let paths = map(copy(a:lines), 'fnamemodify(v:val, ":p")')
  let @+ = join(paths, "\n")
  echom 'Copied: ' . join(paths, ', ')
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-y': function('s:copy_path'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" -----------------------------------------------------------------------------
" コマンドカスタマイズ
" -----------------------------------------------------------------------------
" Files をプレビュー付きに上書き
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" -----------------------------------------------------------------------------
" レイアウト
" -----------------------------------------------------------------------------
let g:fzf_layout = { 'down': '40%' }

" -----------------------------------------------------------------------------
" カラー設定
" -----------------------------------------------------------------------------
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'query':   ['fg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" -----------------------------------------------------------------------------
" 履歴
" -----------------------------------------------------------------------------
let g:fzf_history_dir = '~/.local/share/fzf-history'

" -----------------------------------------------------------------------------
" コマンドカスタマイズ
" -----------------------------------------------------------------------------
" Files をプレビュー付きに上書き
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
