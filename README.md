# 要求環境

Ruby 2.4.2
Rails 5.1.4
MySQL 5.7.x
Node.js 6.11.1

# 開発環境セットアップ手順

```
git clone git@github.com:mokuo/pomodoro-rails.git
cd pomodoro-rails
```

## パッケージのインストール

事前に Yarn がインストールされている必要がある
[Installation \| Yarn](https://yarnpkg.com/en/docs/install)

```
yarn install
bundle install --path vendor/bundle
```

## 環境変数の設定

`.env.sample` をコピーして `.env` に値を設定する

```
cp .env.sample .env
```

| キー              | 説明                                 | 例・備考     |
|-------------------|--------------------------------------|--------------|
| DB_USER           | 開発データベースのユーザ名           | root         |
| DB_PASS           | 開発データベースのパスワード         |              |

## データベースの初期化

```
bin/rails db:create db:migrate
```

## 開発サーバーの起動

```
bundle exec foreman start
```

## テスト実行

```
bin/rspec
```
