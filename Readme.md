# Swift Assignment1 - SQLite Database Test App

## 概要

このプロジェクトは、SwiftUI と SQLite3 を使用したシンプルなデータベーステストアプリケーションです。ユーザー情報の登録・取得機能を実装し、SQLite データベースの基本的な操作（CREATE、INSERT、SELECT）を学習するためのサンプルアプリです。

## 主な機能

- SQLite データベースの初期化
- ユーザーテーブルの作成
- テストデータの挿入
- 全ユーザー情報の取得・表示
- データベース操作の状態表示

## 技術仕様

- **言語**: Swift 5.0
- **フレームワーク**: SwiftUI
- **データベース**: SQLite3
- **対応プラットフォーム**: iOS 18.5+, macOS 15.5+, visionOS 2.5+
- **開発環境**: Xcode 16.4

## プロジェクト構成

```
Swift_Assignment1/
├── Swift_Assignment1.xcodeproj/          # Xcodeプロジェクトファイル
├── Swift_Assignment1/
│   ├── Swift_Assignment1App.swift        # アプリのエントリーポイント
│   ├── ContentView.swift                 # メインのUI
│   ├── DatabaseManager.swift             # SQLiteデータベース管理クラス
│   ├── Swift_Assignment1.entitlements    # アプリの権限設定
│   └── Assets.xcassets/                  # アプリのアセット
```

## データベース設計

### Users テーブル

| カラム名 | データ型 | 制約                      | 説明                    |
| -------- | -------- | ------------------------- | ----------------------- |
| id       | INTEGER  | PRIMARY KEY AUTOINCREMENT | ユーザー ID（自動採番） |
| name     | TEXT     | NOT NULL                  | ユーザー名              |
| email    | TEXT     | NOT NULL                  | メールアドレス          |
| age      | INTEGER  | -                         | 年齢                    |

## 主要なクラス・構造体

### User 構造体

```swift
struct User {
    let id: Int
    let name: String
    let email: String
    let age: Int
}
```

### DatabaseManager クラス

SQLite データベースの操作を管理するクラスです。

**主要メソッド:**

- `createTable()`: Users テーブルを作成
- `insertUser(name:email:age:)`: 新しいユーザーを挿入
- `getAllUsers()`: 全ユーザー情報を取得

### ContentView

SwiftUI のメインビューで、以下の機能を提供します：

- データベース初期化状態の表示
- テストデータ挿入ボタン
- 登録済みユーザー一覧の表示

## セットアップ・実行方法

1. **プロジェクトのクローン**

```bash
# プロジェクトファイルをダウンロード
```

2. **Xcode でプロジェクトを開く**

```bash
open Swift_Assignment1.xcodeproj
```

3. **ビルド・実行**

- Xcode でプロジェクトを開く
- ターゲットデバイス（シミュレーターまたは実機）を選択
- `Cmd + R` でビルド・実行

## 使用方法

1. **アプリ起動時**

   - 自動的にデータベースが初期化されます
   - "データベース初期化完了" メッセージが表示されます

2. **テストデータの挿入**

   - "データベースをテスト" ボタンをタップ
   - 3 人のテストユーザー（James、Sophia、John）が自動挿入されます

3. **データ確認**
   - 挿入後、登録済みユーザー一覧が画面に表示されます
   - 各ユーザーの ID、名前、メール、年齢が確認できます

## テストデータ

アプリには以下のテストデータが含まれています：

| 名前   | メール             | 年齢 |
| ------ | ------------------ | ---- |
| James  | james@example.com  | 25   |
| Sophia | sophia@example.com | 30   |
| John   | john@example.com   | 28   |

## データベースファイルの保存場所

SQLite データベースファイルは以下の場所に保存されます：

```
{アプリのDocumentsディレクトリ}/database.sqlite
```

## 注意点

- このアプリはサンドボックス環境で動作します（App Sandbox が有効）
- データベースファイルはアプリの Documents ディレクトリに作成されます
- 初回実行時にはデータベースとテーブルが自動作成されます
- ユーザーデータは重複挿入される可能性があります（重複チェック未実装）

## 学習ポイント

このプロジェクトを通じて以下の技術を学習できます：

- SwiftUI での UI 構築
- SQLite3 C API の使用方法
- データベースの基本操作（DDL、DML）
- 非同期処理（DispatchQueue）の実装
- Swift での MVVM 的なアーキテクチャパターン

## ライセンス

このプロジェクトは学習目的で作成されています。
