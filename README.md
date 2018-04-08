# 要求環境

- Ruby 2.4.2
- Rails 5.1.4
- MySQL 5.7.x
- Node.js 6.11.1
- yarn

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
gem install -N bundler # bundler がインストール済の場合不要
bundle install --path vendor/bundle
```

## database.yml の設定

`database.yml.sample` をコピーして `database.yml` を作成する。

必要に応じて、 `username`, `password` を設定する。

## データベースの初期化

```
bin/rails db:create db:migrate
```

## 開発サーバーの起動

```
bin/dev-server
```

## テスト実行

```
bin/rspec
```
