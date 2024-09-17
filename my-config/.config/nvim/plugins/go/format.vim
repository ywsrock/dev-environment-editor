" ファイル名: ~/.config/nvim/ftplugin/go/format.vim

" gofumpt コマンドが存在するか確認する関数
function! s:check_gofumpt() abort
    if !executable('gofumpt')
        echoerr "gofumpt command not found. Please install it."
        return 0
    endif
    return 1
endfunction

" 現在のファイルに gofumpt を適用する関数
function! s:apply_gofumpt() abort
    if s:check_gofumpt()
        let l:current_file = expand('%:p')
        silent! execute "!gofumpt -w " . l:current_file
        edit!  " ファイルを再読み込み
    endif
endfunction

" 既存の自動コマンドをクリア
augroup go_format
    autocmd!
augroup END

" Go ファイルの保存時に gofumpt を実行
augroup go_format
    autocmd BufWritePost <buffer> call s:apply_gofumpt()
    autocmd VimLeavePre <buffer> if &modified | call s:apply_gofumpt() | endif
augroup END
