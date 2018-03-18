# API ドキュメント

- [認証について](#about-authentication)
- [エラーについて](#about-error)
- [プロジェクト一覧](#project-list)
- [進行中プロジェクト一覧](#in-progress-project-list)
- [タスク付きプロジェクト一覧](#project-list-with-tasks)
- [タスク新規作成](#create-task)
- [タスク更新](#update-task)
- [タスク削除](#delete-task)
- [ポモドーロ新規作成](#create-pomodoro)
- [ポモドーロ更新](#update-pomodoro)
- [ポモドーロ削除](#delete-pomodoro)

<a name="about-authentication"></a>
## 認証について

<a name="about-error"></a>
## エラーについて

- 成功時のエラーコードは、0
- エラー時のエラーコードは、0 以外
- エラー時は、エラーコードとエラーメッセージを返す

**レスポンス例**

```json
{
  "error": {
    "code": 400,
    "message": "エラーメッセージ"
  }
}
```

<a name="project-list"></a>
## プロジェクト一覧

- 概要
  - プロジェクト一覧を取得する
- メソッド
  - GET
- URL
  - /api/v1/projects
- パラメータ
  - なし

**curl でのリクエスト例**

```bash
curl -X GET \
  'http://localhost:5000/api/v1/projects' \
  -H 'accept: application/json'
```

**レスポンス例**

```json
{
  "error": {
    "code": 0
  },
  "projects": [
    {
      "id": 1,
      "name": "プロジェクト１",
      "stopped?": false
    },
    {
      "id": 3,
      "name": "プロジェクト３",
      "stopped?": false
    },
    {
      "id": 2,
      "name": "プロジェクト２",
      "stopped?": true
    }
  ]
}
```

<a name="in-progress-project-list"></a>
## 進行中プロジェクト一覧

- 概要
  - 停止されていないプロジェクト一覧を取得する
- メソッド
  - GET
- URL
  - /api/v1/projects/in_progresses
- パラメータ
  - なし

**curl でのリクエスト例**

```bash
curl -X GET \
  'http://localhost:5000/api/v1/projects/in_progresses' \
  -H 'accept: application/json'
```

**レスポンス例**

```json
{
  "error": {
    "code": 0
  },
  "projects": [
    {
      "id": 1,
      "name": "プロジェクト１"
    },
    {
      "id": 3,
      "name": "プロジェクト３"
    }
  ]
}
```

<a name="project-list-with-tasks"></a>
## タスク付きプロジェクト一覧

- 概要
  - プロジェクト一覧と、指定された日付のタスク・ポモドーロを取得する
- メソッド
  - GET
- URL
  - /api/v1/todos
- パラメータ
  - date

**curl でのリクエスト例**

```bash
curl -X GET \
  'http://localhost:5000/api/v1/todos?date=2017-11-02' \
  -H 'accept: application/json'
```

**レスポンス例**

```json
{
  "error": {
    "code": 0
  },
  "date": "2017-11-02",
  "projects": [
    {
      "id": 2,
      "name": "テストプロジェクト",
      "is_default": false,
      "tasks": [
        {
          "id": 1,
          "name": "タスク１",
          "done": false,
          "pomodoros": [
            {
              "id": 1,
              "box": "square",
              "done": false
            },
            {
              "id": 2,
              "box": "circle",
              "done": false
            }
          ]
        }
      ]
    },
    {
      "id": 1,
      "name": "no project",
      "is_default": true,
      "tasks": []
    }
  ]
}
```

<a name="create-task"></a>
## タスク新規作成

- 概要
  - タスクを新規作成する
- メソッド
  - POST
- URL
  - /api/v1/projects/:project_id/tasks
- パラメータ
  - name
  - todo_on

**curl でのリクエスト例**

```bash
curl -X POST \
  'http://localhost:5000/api/v1/projects/1/tasks' \
  -H 'accept: application/json' \
  -H 'content-type: application/json' \
  -d '{ "name": "タスクA", "todo_on": "2017-11-19" }'
```

**レスポンス例**

```json
{
  "error": {
    "code": 0
  },
  "task": {
    "id": 1,
    "name": "タスクA",
    "done": false,
    "todo_on": "2017-11-19",
    "project_id": 1
  }
}
```

<a name="update-task"></a>
## タスク更新

- 概要
  - タスクを更新する
- メソッド
  - PATCH
- URL
  - /api/v1/tasks/:id
- パラメータ
  - どちらか片方
    - name
    - done

**curl でのリクエスト例**

```bash
curl -X PATCH \
  'http://localhost:5000/api/v1/tasks/1' \
  -H 'accept: application/json' \
  -H 'content-type: application/json' \
  -d '{ "done": true }'
```

**レスポンス例**

```json
{
  "error": {
    "code": 0
  },
  "task": {
    "id": 1,
    "name": "タスクA",
    "done": true,
    "todo_on": "2017-11-19",
    "project_id": 1
  }
}
```

<a name="delete-task"></a>
## タスク削除

- 概要
  - タスク削除する
- メソッド
  - DELETE
- URL
  - /api/v1/tasks/:id
- パラメータ
  - なし

**curl でのリクエスト例**

```bash
curl -X DELETE \
  'http://localhost:5000/api/v1/tasks/1' \
  -H 'accept: application/json'
```

**レスポンス例**

```json
{
  "error": {
    "code": 0
  }
}
```

<a name="create-pomodoro"></a>
## ポモドーロ新規作成

- 概要
  - ポモドーロを新規作成する
- メソッド
  - POST
- URL
  - /api/v1/tasks/:task_id/pomodoros
- パラメータ
  - task_id
  - box

**curl でのリクエスト例**

```bash
curl -X POST \
  'http://localhost:5000/api/v1/tasks/1/pomodoros' \
  -H 'accept: application/json' \
  -H 'content-type: application/json' \
  -d '{ "box": "square" }'
```

**レスポンス例**

```json
{
  "error": {
    "code": 0
  },
  "pomodoro": {
    "id": 1,
    "box": "square",
    "done": false,
    "task_id": 1
  }
}
```

<a name="update-pomodoro"></a>
## ポモドーロ更新

- 概要
  - ポモドーロを更新する
- メソッド
  - PATCH
- URL
  - /api/v1/pomodoros/:id
- パラメータ
  - done

**curl でのリクエスト例**

```bash
curl -X PATCH \
  'http://localhost:5000/api/v1/pomodoros/1' \
  -H 'accept: application/json' \
  -H 'content-type: application/json' \
  -d '{ "done": true }'
```

**レスポンス例**

```json
{
  "error": {
    "code": 0
  },
  "pomodoro": {
    "id": 1,
    "box": "square",
    "done": true,
    "task_id": 1
  }
}
```

<a name="delete-pomodoro"></a>
## ポモドーロ削除

- 概要
  - ポモドーロ削除する
- メソッド
  - DELETE
- URL
  - /api/v1/pomodoros/:id
- パラメータ
  - なし

**curl でのリクエスト例**

```bash
curl -X DELETE \
  'http://localhost:5000/api/v1/pomodoros/1' \
  -H 'accept: application/json'
```

**レスポンス例**

```json
{
  "error": {
    "code": 0
  }
}
```
