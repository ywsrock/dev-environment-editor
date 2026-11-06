-- =============================================================================
-- md_preview.lua - nvim-md-preview（Markdown プレビュー）設定
-- =============================================================================
-- コマンド:
--   :MdPreview               プレビューを開始
--   :MdPreviewStop           プレビューを停止
--   :MdPreviewInfo [copy]    URL などの状態を表示（copy で URL をコピー）
--   :MdPreviewExport {形式}  pdf / slides / docx / html / epub / markdown で出力
-- 設定できる項目: :help md-preview-configuration

require("md_preview").setup({
  -- タブやアドレスバーの無いアプリ風のウィンドウで開く（Chrome / Edge / Brave / Chromium）
  browser_app = true,
})
