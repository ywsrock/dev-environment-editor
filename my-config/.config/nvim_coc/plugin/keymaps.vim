" =============================================================================
" keymaps.vim - キーマッピング
" =============================================================================

" -----------------------------------------------------------------------------
" 検索ハイライト解除
" -----------------------------------------------------------------------------
nnoremap <ESC><ESC> :nohlsearch<CR>

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
let g:quickr_preview_keymaps = 0
nmap gs <plug>(quickr_preview)
nmap gc <plug>(quickr_preview_qf_close)
let g:quickr_preview_position = 'right'

" -----------------------------------------------------------------------------
" Markdown プレビュー
" -----------------------------------------------------------------------------
nmap <leader>gs <Plug>MarkdownPreview
nmap <leader>gc <Plug>MarkdownPreviewStop
nmap <leader>gt <Plug>MarkdownPreviewToggle
let g:mkdp_command_for_global = 1

" -----------------------------------------------------------------------------
" Telescope / fzf
" -----------------------------------------------------------------------------
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({ cwd = vim.g.project_root, find_command = { "rg", "--files", "--hidden", "--no-ignore", "--glob", "!.git/", "--glob", "!node_modules/" } })<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fz <cmd>FZF .<cr>

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
