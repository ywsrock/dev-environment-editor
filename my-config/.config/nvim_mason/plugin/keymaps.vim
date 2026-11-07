" =============================================================================
" keymaps.vim - キーマッピング
" =============================================================================

" -----------------------------------------------------------------------------
" 検索ハイライト解除
" -----------------------------------------------------------------------------
nnoremap <ESC><ESC> :nohlsearch<CR>

" -----------------------------------------------------------------------------
" 保存（:update = 変更がある時だけ保存 → 無駄な clippy 実行を防ぐ）
"   <C-s> : ノーマル / 挿入 / ビジュアル（挿入モードは抜けない）
"   ※ 挿入モードの <C-s> は Neovim 標準のシグネチャヘルプを上書きする
" -----------------------------------------------------------------------------
nnoremap <C-s> <cmd>update<CR>
inoremap <C-s> <cmd>update<CR>
xnoremap <C-s> <cmd>update<CR>

" -----------------------------------------------------------------------------
" NERDTree
" -----------------------------------------------------------------------------
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" -----------------------------------------------------------------------------
" quickfix プレビュー
" -----------------------------------------------------------------------------
" quickfix / location list のウィンドウの中だけで有効（ふつうのファイルでは
" gc が Neovim 標準のコメント gc{motion}（例: gcj）と重なるため、バッファ専用にする）
"   gs : カーソル行のプレビュー / gc : quickfix・location list のウィンドウを閉じる
let g:quickr_preview_keymaps = 0
let g:quickr_preview_position = 'right'
augroup QuickrPreviewKeymaps
  autocmd!
  autocmd FileType qf nmap <buffer> gs <plug>(quickr_preview)
  autocmd FileType qf nmap <buffer> gc <plug>(quickr_preview_qf_close)
augroup END

" quickfix / location list の表示切り替え（開いていれば閉じる、閉じていれば開く）
nnoremap <leader>q <cmd>execute getqflist({'winid': 0}).winid ? 'cclose' : 'copen'<CR>
nnoremap <leader>l <cmd>execute getloclist(0, {'winid': 0}).winid ? 'lclose' : 'lopen'<CR>

" -----------------------------------------------------------------------------
" Markdown プレビュー（nvim-md-preview）
" -----------------------------------------------------------------------------
nmap <leader>ms <cmd>MdPreview<cr>
nmap <leader>mc <cmd>MdPreviewStop<cr>
nmap <leader>mr <cmd>MarkdownPreviewToggle<cr>
nmap <leader>md <cmd>MdPreviewDiff<cr>

" -----------------------------------------------------------------------------
" Telescope / fzf
" -----------------------------------------------------------------------------
"nnoremap <leader>fg <cmd>Telescope live_grep<cr>
"nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" ,ff / ,fg は起動したフォルダー（g:project_root）から検索する
" （autochdir で作業フォルダーが開いているファイルの場所に変わるため）
nnoremap <leader>ff <cmd>execute 'Files' fnameescape(g:project_root)<cr>
" 小文字 = すぐ検索 / 大文字 = 入力してから検索（,fg / ,fG と同じ並び）
nnoremap <leader>fF :Files<Space>

" fzf 追加キーマップ
nnoremap <leader>fg <cmd>RgRoot<CR>
nnoremap <leader>fG :RgRoot<Space>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>h :History:<CR>

" キー割り当ての一覧（入力で絞り込み、Enter でそのキーを実行）
nnoremap <leader>km <cmd>Telescope keymaps<CR>

" 今開いているファイルの場所で検索
"   ,fd / ,fD : 今のファイルのフォルダーから ファイル / 文字列 を検索
"               （autochdir で作業フォルダー = 今のファイルのフォルダー）
"   ,fl       : 今のファイルの中の行を検索
nnoremap <leader>fd <cmd>Files<CR>
nnoremap <leader>fD <cmd>Rg<CR>
nnoremap <leader>fl <cmd>BLines<CR>

" マーク（m で付けたもの）の一覧（プレビュー付き、Enter でジャンプ）
nnoremap <leader>fm <cmd>Telescope marks<CR>

" -----------------------------------------------------------------------------
" 翻訳
" -----------------------------------------------------------------------------
let g:translator_target_lang = 'ja'
nmap <silent> <Leader>t <Plug>Translate
vmap <silent> <Leader>t <Plug>TranslateV
nmap <silent> <Leader>w <Plug>TranslateW
vmap <silent> <Leader>w <Plug>TranslateWV
" 置き換えは ,R（,r だと LSP のリネーム ,rn と重なり、押してから1秒待たされるため）
nmap <silent> <Leader>R <Plug>TranslateR
vmap <silent> <Leader>R <Plug>TranslateRV
nmap <silent> <Leader>x <Plug>TranslateX
nnoremap <silent><expr> <M-f> translator#window#float#has_scroll() ?
      \ translator#window#float#scroll(1) : "\<M-f>"
nnoremap <silent><expr> <M-b> translator#window#float#has_scroll() ?
      \ translator#window#float#scroll(0) : "\<M-b>"

" -----------------------------------------------------------------------------
" Diffview (Git)
" -----------------------------------------------------------------------------
nnoremap <leader>gd :DiffviewOpen<CR>
nnoremap <leader>gD :DiffviewClose<CR>
nnoremap <leader>gh :DiffviewFileHistory<CR>
nnoremap <leader>gH :DiffviewFileHistory %<CR>

" -----------------------------------------------------------------------------
" Noice 通知履歴
" -----------------------------------------------------------------------------
"（,nh だと NERDTree の ,n と重なり、,n を押してから1秒待たされるため ,N）
nnoremap <leader>N <cmd>lua require("telescope").extensions.notify.notify()<cr>

" -----------------------------------------------------------------------------
" Floaterm（VSCode以外）
" -----------------------------------------------------------------------------
if !exists('g:vscode')
  let g:floaterm_keymap_new = '<Leader>fc'
  let g:floaterm_keymap_prev = '<Leader>fp'
  let g:floaterm_keymap_next = '<Leader>fn'
  let g:floaterm_keymap_first= '<Leader>f^'
  let g:floaterm_keymap_last = '<Leader>f$'
  let g:floaterm_keymap_hide = '<Leader>fh'
  let g:floaterm_keymap_show = '<Leader>fs'
  let g:floaterm_keymap_kill = '<Leader>fk'
  let g:floaterm_keymap_toggle= '<Leader>ft'
  let g:floaterm_wintype = 'float'
  let g:floaterm_position = 'bottomright'
endif

" -----------------------------------------------------------------------------
" Copilot（VSCode以外。copilot.vim が pack/ に入っている時だけ）
" 入っていない時に設定すると、挿入モードの <C-j> / <C-k> / <C-l> が効かなくなるため
" -----------------------------------------------------------------------------
if !exists('g:vscode') && !empty(globpath(&packpath, 'pack/*/start/copilot.vim', 0, 1))
  let g:copilot_filetypes = {
        \   '*': v:true,
        \}
  nmap <leader>cp :Copilot panel<CR>
  imap <C-j> <Plug>(copilot-next)
  imap <C-k> <Plug>(copilot-previous)
  imap <C-l> <Plug>(copilot-accept-word)
endif
