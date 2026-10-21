-- =============================================================================
-- mdkite.lua - Markdown プレビュー設定（mdkite.nvim）
-- =============================================================================

require("mdkite").setup({
  -- インスタンスモード: "takeover"（1タブ共有）または "multi"（複数タブ）
  instance_mode = "takeover",

  -- ポート: 0 = 自動（takeover: 8421, multi: OS割り当て）
  port = 0,

  -- ブラウザを自動で開く
  open_browser = true,

  -- デフォルトテーマ: "dark" または "light"
  default_theme = "dark",

  -- 更新のデバウンス間隔（ミリ秒）
  debounce_ms = 300,

  -- 自動更新
  auto_refresh = true,

  -- スクロール同期
  scroll_sync = true,

  -- Mermaidレンダラー: "js"（ブラウザ）または "rust"（高速、要インストール）
  mermaid_renderer = "js",

  -- YAMLフロントマター: "panel", "hide", "raw"
  yaml_mode = "panel",
})
