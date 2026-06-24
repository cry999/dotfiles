# 改善点・アイデアまとめ

リポジトリ全体を調査した結果をまとめます。

---

## テーマの不整合

各ツールで異なるCatppuccinバリアントが設定されている:

| ツール | バリアント |
|--------|-----------|
| WezTerm | Macchiato |
| Ghostty | **Mocha** |
| SketchyBar | Macchiato |
| Borders | Macchiato |
| Btop | Macchiato |
| LazyGit | **Frappe** |
| Yazi | Macchiato |
| Git Delta | Macchiato |
| Neovim | Macchiato |

Ghostty と LazyGit が他と異なる。意図的でなければ統一を検討。

> [!success] 方針
>
> Mocha で統一する。Next Action としてツール間でのテーマを統一するためのツールの構想を立てる。

---

---

## Homebrew Brewfile の不足パッケージ

SketchyBarの `wifi.sh` が `ifstat` に依存しているが、Brewfileに含まれていない。
その他、btop, yazi, borders (JankyBorders), ghostty, aerospace, sketchybar なども Brewfile に記載がない。

---

## 改善アイデア

### 1. テーマの一元管理

現状、カラーパレットが複数箇所で重複定義されている:
- `wezterm/.config/wezterm/colors.lua` — 抹茶ラテカスタムパレット
- `sketchybar/.config/sketchybar/colors.sh` — 同じ抹茶ラテパレット
- `borders/.config/borders/bordersrc` — Macchiato色がハードコード

**アイデア**: `flavour-switch` 関数を拡張して、borders やその他のツールにもテーマを反映させる。あるいは、共有のカラー定義ファイルを作成して各ツールから参照する。

### 2. Neovim の Inlay Hint 二重有効化

`autocmds.lua` の `LSPInlayHintEnable` と `lua/lsp/ts_ls.lua` の `on_attach` で、inlay hint を二重に有効化している。`autocmds.lua` で全サーバー共通で有効化しているため、`ts_ls.lua` 側の処理は不要。

### 3. `y()` 関数の `rm -rf`

`.zshrc:40` で一時ファイルに `rm -rf` を使用している。`rm -f` で十分。

### 4. Starship テーマファイルの重複

`setup.sh` で生成される4つのテーマファイル（`starship.latte.toml` 等）は、ベース設定の全コピーにパレット行を追加したもの。パレット定義自体もベースファイルに含まれているため、テーマファイルごとに大量の重複がある。

### 5. `snacks.nvim` への dashboard 移行

`nvim/.config/nvim/lua/plugins/snacks.lua:18` に TODO コメントあり。現在は `alpha-nvim` を使用中だが、snacks の dashboard への移行が検討されている。

### 6. rust-analyzer の自動インストール

現在 `brew install rust-analyzer` で手動インストールが必要。`rustup` 管理の Rust ツールチェインに切り替えれば `rustup component add rust-analyzer` で統一管理できる。あるいは、Brewfile に `rust-analyzer` を追加して `setup.sh` で自動化する方法もある。

### 7. likec4 tree-sitter クエリのシンボリックリンク

`setup.sh:62-65` にコメントアウトで残っている。自動化するか、削除するかを決定する必要がある。

---

## TODO 一覧（コード内に散在）

| ファイル | 行 | 内容 |
|---------|-----|------|
| `nvim/.config/nvim/lua/autocmds.lua` | 1 | `colorify_ns` に適切なnamespaceを作成 |
| `nvim/.config/nvim/lua/plugins/snacks.lua` | 18 | alpha dashboard → snacks に移行 |

| `nvim/.config/nvim/ftplugin/org.lua` | 3-7 | Reader mode 実装 |
| `wezterm/.config/wezterm/wezterm.lua` | 124 | `max_width` を config から取得 |
| `wezterm/.config/wezterm/wezterm.lua` | 283 | vertical split 未実装 |
| `setup.sh` | 62-65 | likec4 tree-sitter クエリのシンボリックリンク |
