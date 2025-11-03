# VSCode形式スニペットの配置場所

このディレクトリに、VSCode形式のJSONスニペットファイルを配置してください。

## ファイル名の形式

ファイルタイプごとにJSONファイルを作成します：

- `sql.json` - SQL用スニペット
- `javascript.json` - JavaScript用スニペット
- `typescript.json` - TypeScript用スニペット
- `python.json` - Python用スニペット
- など...

## VSCodeからのコピー方法

### 1. VSCodeのスニペットファイルを探す

VSCodeでスニペットファイルを開く：
- `Cmd+Shift+P` (macOS) または `Ctrl+Shift+P` (Windows/Linux)
- "Preferences: Configure User Snippets" を選択
- 使用したいファイルタイプ（例: sql）を選択

### 2. JSON内容をコピー

VSCodeで開いたスニペットファイルの内容を全てコピーします。

### 3. Neovimに配置

このディレクトリに、`{filetype}.json` という名前でファイルを作成し、コピーした内容を貼り付けます。

例：`sql.json` ファイルを作成して、SQL用のスニペットを貼り付ける。

## スニペットファイルの形式

VSCode形式のJSONスニペットファイルの例：

```json
{
  "Snippet Name": {
    "prefix": "trigger",
    "body": [
      "line 1",
      "line 2"
    ],
    "description": "Description of the snippet"
  }
}
```

## 注意事項

- JSONファイルは有効なJSON形式である必要があります
- ファイル名は `{filetype}.json` の形式である必要があります
- スニペットは自動的に読み込まれます（Neovim再起動不要の場合もあります）

