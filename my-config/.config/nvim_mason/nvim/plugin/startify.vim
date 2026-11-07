" =============================================================================
" startify.vim - vim-startify 設定
" =============================================================================

" -----------------------------------------------------------------------------
" Git 連携関数
" -----------------------------------------------------------------------------
" 変更されたファイルを取得
" ※ git リポジトリ外ではエラーになるので空のリストを返す
"   （2>/dev/null は Windows で使えないため v:shell_error で判定）
function! s:gitModified()
    let files = systemlist('git ls-files -m')
    return v:shell_error ? [] : map(files, "{'line': v:val, 'path': v:val}")
endfunction

" 未追跡ファイルを取得
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard')
    return v:shell_error ? [] : map(files, "{'line': v:val, 'path': v:val}")
endfunction

" -----------------------------------------------------------------------------
" リスト設定
" -----------------------------------------------------------------------------
let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]

" -----------------------------------------------------------------------------
" NERDTree ブックマーク連携
" -----------------------------------------------------------------------------
"   ~/.NERDTreeBookmarks の各行「名前 パス」からパスを取り出す
"   ファイルが無い時（NERDTree でブックマークを作っていない人）は空にする
"   （以前は cut コマンドを使っていたため、ファイルが無いとエラーの文字が表示され、Windows では動かなかった）
let s:nerdtree_bookmarks = expand('~/.NERDTreeBookmarks')
let g:startify_bookmarks = filereadable(s:nerdtree_bookmarks)
      \ ? map(filter(readfile(s:nerdtree_bookmarks), {_, l -> l =~# ' '}), {_, l -> matchstr(l, ' \zs.*')})
      \ : []
