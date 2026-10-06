" =============================================================================
" coc.vim - coc.nvim 設定
" =============================================================================

" VSCode の場合は無効化
if exists("g:vscode")
  let g:coc_start_at_startup = 0
  finish
endif

" -----------------------------------------------------------------------------
" 自動インストールする拡張機能
" -----------------------------------------------------------------------------
let g:coc_global_extensions = [
  \ 'coc-calc',
  \ 'coc-cfn-lint',
  \ 'coc-css',
  \ 'coc-diagnostic',
  \ 'coc-docker',
  \ 'coc-eslint',
  \ 'coc-fzf-preview',
  \ 'coc-git',
  \ 'coc-go',
  \ 'coc-golines',
  \ 'coc-html',
  \ 'coc-htmlhint',
  \ 'coc-java',
  \ 'coc-json',
  \ 'coc-markdownlint',
  \ 'coc-perl',
  \ 'coc-powershell',
  \ 'coc-prettier',
  \ 'coc-pyright',
  \ 'coc-rust-analyzer',
  \ 'coc-sh',
  \ 'coc-snippets',
  \ 'coc-spell-checker',
  \ 'coc-sql',
  \ 'coc-sqlfluff',
  \ 'coc-toml',
  \ 'coc-tsserver',
  \ 'coc-vetur',
  \ 'coc-vimlsp',
  \ 'coc-xml',
  \ 'coc-yaml'
  \ ]

" ログレベル
let g:coc_log_level = 'error'

" -----------------------------------------------------------------------------
" 補完
" -----------------------------------------------------------------------------
" Tab で補完候補を選択
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Enter で補完確定
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Ctrl+Space で補完をトリガー
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" -----------------------------------------------------------------------------
" ナビゲーション
" -----------------------------------------------------------------------------
" 診断メッセージ間を移動
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" コードナビゲーション
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" -----------------------------------------------------------------------------
" ドキュメント
" -----------------------------------------------------------------------------
" K でドキュメント表示
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" カーソル位置のシンボルをハイライト
autocmd CursorHold * silent call CocActionAsync('highlight')

" -----------------------------------------------------------------------------
" リファクタリング
" -----------------------------------------------------------------------------
" シンボル名変更
nmap <leader>rn <Plug>(coc-rename)

" コードフォーマット
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" コードアクション
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
nmap <leader>as  <Plug>(coc-codeaction-source)
nmap <leader>qf  <Plug>(coc-fix-current)

" リファクタリング
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>ra  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>ra  <Plug>(coc-codeaction-refactor-selected)

" Code Lens
nmap <leader>cl  <Plug>(coc-codelens-action)

" -----------------------------------------------------------------------------
" テキストオブジェクト
" -----------------------------------------------------------------------------
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" -----------------------------------------------------------------------------
" スクロール
" -----------------------------------------------------------------------------
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" 選択範囲
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" -----------------------------------------------------------------------------
" コマンド
" -----------------------------------------------------------------------------
command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" -----------------------------------------------------------------------------
" CocList マッピング
" -----------------------------------------------------------------------------
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" -----------------------------------------------------------------------------
" ステータスライン
" -----------------------------------------------------------------------------
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" -----------------------------------------------------------------------------
" autocmd
" -----------------------------------------------------------------------------
augroup coc_group
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
