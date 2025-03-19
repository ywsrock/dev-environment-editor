" ファイル名: ~/.config/nvim/plugin/python/format.vim

" autopep8 コマンドが存在するか確認する関数
function! s:check_autopep8() abort
    if !executable('autopep8')
        echoerr "autopep8 command not found. Please install it with 'pip install autopep8'."
        return 0
    endif
    return 1
endfunction

" 現在のファイルに autopep8 を適用する関数
function! s:apply_autopep8() abort
    if s:check_autopep8()
        let l:current_file = expand('%:p')
        " autopep8 のオプションをカスタマイズできます
        " --in-place: ファイルを直接変更
        " --max-line-length: 最大行長
        " --indent-size: インデントサイズ
        " --ignore: 無視するエラーコード
        silent! execute "!autopep8 --in-place --max-line-length=120 --indent-size=4 --ignore=E402,E701,E221,E265 " . l:current_file
        edit!  " ファイルを再読み込み
    endif
endfunction

" 既存の自動コマンドをクリア
augroup python_format
    autocmd!
augroup END

" Python ファイルの保存時に autopep8 を実行
augroup python_format
    autocmd BufWritePost <buffer> call s:apply_autopep8()
    autocmd VimLeavePre <buffer> if &modified | call s:apply_autopep8() | endif
augroup END
