# CLAUDE.md

Please communicate in Japanese (日本語).

## Overview

macOS dotfiles repository. GNU Stow manages symlinks from each top-level package directory to `$HOME`.

**詳細なアーキテクチャ情報は `docs/` を参照:**
- [`docs/architecture.md`](docs/architecture.md) — Stow パッケージ、セットアップ、テーマシステム、Git 設定
- [`docs/neovim.md`](docs/neovim.md) — Neovim 設定、LSP、プラグイン、キーマッピング
- [`docs/zsh.md`](docs/zsh.md) — Zsh 設定、読み込み順序、スクリプト

## Coding Conventions

- **Stow パッケージ追加時**: `setup.sh` の `stow` コマンドにも追加すること
- **LSP 設定**: 必ず mason-lspconfig handlers 経由で行う。直接 `lspconfig[server].setup()` を呼ばない（詳細は `docs/neovim.md`）
- **XDG Base Directory**: すべての設定は stow パッケージ内の `.config/` 構造を使用
- **Neovim キーマッピング**: `lua/mappings/` の適切なカテゴリファイルに追加し、`mappings/init.lua` で which-key グループを登録
- **Neovim プラグイン**: `lua/plugins/` に1ファイル1プラグイン。Lazy.nvim が自動検出
- **Shell スクリプト**: bash スクリプトでは `set -euo pipefail` を使用
- **末尾空白なし**: Neovim の `TrimTrailingWhitespace` autocmd で自動削除

## Working Rules

### ドキュメントの継続的な整備
- **CLAUDE.md と docs/ は常に最新の状態を保つ**: 設定の追加・変更・削除時に該当箇所を更新する
- **発見したパターンや注意点を反映する**: 規約、落とし穴、ツール間の依存関係など
- **設定ファイルのコメントも整備する**: 実態と乖離していないか確認
- **修正済みの項目はドキュメントから削除する**: 未対応リストとして機能させる

### セルフ振り返り
- **作業完了時に必ず振り返りを実施**: 知見・反省点・改善アイデアをユーザーに報告
- **知見はメモリ（MEMORY.md）に記録**: 次のセッションで同じ失敗を繰り返さない

## Known Issues

See `IMPROVEMENTS.md`.
