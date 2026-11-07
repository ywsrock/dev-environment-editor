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
" gc が Comment.nvim の gc{motion}（例: gcj）と重なるため、バッファ専用にする）
"   gs : カーソル行のプレビュー / gc : プレビューを閉じる
let g:quickr_preview_keymaps = 0
let g:quickr_preview_position = 'right'
augroup QuickrPreviewKeymaps
  autocmd!
  autocmd FileType qf nmap <buffer> gs <plug>(quickr_preview)
  autocmd FileType qf nmap <buffer> gc <plug>(quickr_preview_qf_close)
augroup END

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
"nnoremap <leader>ff <cmd>lua require('plugins.telescope').find_files()<cr>
"nnoremap <leader>fg <cmd>Telescope live_grep<cr>
"nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>ff <cmd>Files<cr>
nnoremap <leader>fz :Files<Space>

" fzf 追加キーマップ
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fG :Rg<Space>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>h :History:<CR>

" -----------------------------------------------------------------------------
" 翻訳
" -----------------------------------------------------------------------------
let g:translator_target_lang = 'ja'
nmap <silent> <Leader>t <Plug>Translate
vmap <silent> <Leader>t <Plug>TranslateV
nmap <silent> <Leader>w <Plug>TranslateW
vmap <silent> <Leader>w <Plug>TranslateWV
nmap <silent> <Leader>r <Plug>TranslateR
vmap <silent> <Leader>r <Plug>TranslateRV
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
nnoremap <leader>nh <cmd>lua require("telescope").extensions.notify.notify()<cr>

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
" Copilot（VSCode以外）
" -----------------------------------------------------------------------------
if !exists('g:vscode')
  let g:copilot_filetypes = {
        \   '*': v:true,
        \}
  nmap <leader>cp :Copilot panel<CR>
  imap <C-j> <Plug>(copilot-next)
  imap <C-k> <Plug>(copilot-previous)
  imap <C-l> <Plug>(copilot-accept-word)
endif
