require 'rails_helper'

RSpec.describe 'Api::Tasks', type: :request do
  let(:user) { create :user }

  before do |example|
    login(user) unless example.metadata[:skip_login]
  end

  describe 'POST /api/v1/projects/:project_id/tasks' do
    subject { post "/api/v1/projects/#{project_id}/tasks", params: params, headers: headers }
    let(:headers) { {
      'ACCEPT': 'application/json',
      'CONTENT_TYPE': 'application/json'
    } }

    before do |example|
      subject unless example.metadata[:skip_subject]
    end

    context '正常系' do
      let!(:project) { create :project, user: user }
      let(:project_id) { project.id }
      let(:params) { '{ "name": "test_task", "todo_on": "2017-11-19" }' }

      it_behaves_like '処理成功'

      it 'タスクを新規作成する', :skip_subject do
        expect { subject }.to change { Task.count }.by(1)
      end

      it 'id を返す' do
        expect(response.body).to be_json_eql(Task.last.id).at_path('task/id')
      end

      it 'name を返す' do
        expect(response.body).to be_json_eql('test_task'.to_json).at_path('task/name')
      end

      it 'done を返す' do
        expect(response.body).to be_json_eql(false).at_path('task/done')
      end

      it 'todo_on を返す' do
        expect(response.body).to be_json_eql('2017-11-19'.to_json).at_path('task/todo_on')
      end

      it 'project_id を返す' do
        expect(response.body).to be_json_eql(project.id).at_path('task/project_id')
      end
    end

    context '異常系' do
      context 'パラメーターを指定しない時' do
        let!(:project) { create :project, user: user }
        let(:project_id) { project.id }
        let(:params) { {} }

        it_behaves_like 'パラメーター不足'

        it 'タスクを新規作成しない', :skip_subjct do
          expect { subject }.not_to change { Task.count }
        end
      end

      context '存在しないプロジェクトIDを指定した時' do
        let!(:project) { create :project, user: user }
        let(:project_id) { 0 }
        let(:params) { '{ "name": "test_task", "todo_on": "2017-11-19" }' }

        it_behaves_like '存在しないリソース'

        it 'タスクを新規作成しない', :skip_subjct do
          expect { subject }.not_to change { Task.count }
        end
      end

      context 'バリデーションエラーの時' do
        let!(:project) { create :project, user: user }
        let(:project_id) { project.id }
        let(:params) { '{ "name": "" }' }

        it_behaves_like 'バリデーションエラー'

        it 'タスクを新規作成しない', :skip_subjct do
          expect { subject }.not_to change { Task.count }
        end

        it 'name のバリデーションエラーを返す' do
          expect(response.body).to be_json_eql('タスク名を入力してください'.to_json).at_path('error/messages/0')
        end
      end

      include_context 'ログインしていない時' do
        let!(:project) { create :project, user: user }
        let(:project_id) { project.id }
        let(:params) { '{ "name": "test_task", "todo_on": "2017-11-19" }' }
      end

      context '他のユーザーのプロジェクトを指定した時' do
        let!(:project) { create :project }
        let(:project_id) { project.id }
        let(:params) { '{ "name": "test_task", "todo_on": "2017-11-19" }' }

        it_behaves_like '存在しないリソース'
      end
    end
  end

  describe 'PATCH /api/v1/tasks/:id' do
    subject { patch "/api/v1/tasks/#{task_id}", params: params, headers: headers }
    let(:headers) { {
      'ACCEPT': 'application/json',
      'CONTENT_TYPE': 'application/json'
    } }

    before { subject }

    context '正常系' do
      let!(:project) { create :project, user: user }
      let!(:task) { create :task, name: 'old task', project: project }
      let(:params) { '{ "name": "new task", "done": true, "todo_on": "2018-02-02" }' }
      let(:task_id) { task.id }

      it_behaves_like '処理成功'

      it 'タスク名を更新する' do
        expect { task.reload }.to change { task.name }.from('old task').to('new task')
      end

      it 'done を更新する' do
        expect { task.reload }.to change { task.done }.from(false).to(true)
      end

      it 'todo_on を更新する' do
        expect { task.reload }.to change { task.todo_on }.from(nil).to(Date.new(2018, 2, 2))
      end

      it 'タスクID を返す' do
        expect(response.body).to be_json_eql(task.id).at_path('task/id')
      end

      it '更新されたタスク名を返す' do
        expect(response.body).to be_json_eql('new task'.to_json).at_path('task/name')
      end

      it '更新された done を返す' do
        expect(response.body).to be_json_eql(true).at_path('task/done')
      end

      it '更新された todo_on を返す' do
        expect(response.body).to be_json_eql('2018-02-02'.to_json).at_path('task/todo_on')
      end

      it 'プロジェクトID を返す' do
        expect(response.body).to be_json_eql(task.project.id).at_path('task/project_id')
      end
    end

    context '異常系' do
      context 'タスク名が空の時' do
        let!(:project) { create :project, user: user }
        let!(:task) { create :task, name: 'old task', project: project }
        let(:params) { '{ "name": "" }' }
        let(:task_id) { task.id }

        it_behaves_like 'バリデーションエラー'

        it 'タスク名のバリデーションエラーメッセージを返す' do
          expect(response.body).to be_json_eql('タスク名を入力してください'.to_json).at_path('error/messages/0')
        end
      end

      context 'パラメータが指定されない時' do
        let!(:project) { create :project, user: user }
        let!(:task) { create :task, name: 'old task', project: project }
        let(:params) { '' }
        let(:task_id) { task.id }

        it_behaves_like 'パラメーター不足'
      end

      context '存在しないタスクIDを指定した時' do
        let!(:project) { create :project, user: user }
        let!(:task) { create :task, name: 'old task', project: project }
        let(:params) { '{ "name": "hoge" }' }
        let(:task_id) { 0 }

        it_behaves_like '存在しないリソース'
      end

      include_context 'ログインしていない時' do
        let!(:project) { create :project, user: user }
        let!(:task) { create :task, name: 'old task', project: project }
        let(:params) { '{ "name": "new task", "done": true }' }
        let(:task_id) { task.id }
      end

      context '他のユーザーのタスクを指定した時' do
        let!(:project) { create :project }
        let!(:task) { create :task, name: 'old task', project: project }
        let(:params) { '{ "name": "new task", "done": true }' }
        let(:task_id) { task.id }

        it_behaves_like '存在しないリソース'
      end
    end
  end

  describe 'DELETE /api/v1/tasks/:id' do
    subject { delete "/api/v1/tasks/#{task_id}", headers: headers }
    let(:headers) { {
      'ACCEPT': 'application/json'
    } }
    let!(:project) { create :project, user: user }
    let!(:task) { create :task, project: project }

    before do |example|
      subject unless example.metadata[:skip_subjct]
    end

    context '正常系' do
      let(:task_id) { task.id }

      it_behaves_like '処理成功'

      it 'タスクを削除する', :skip_subjct do
        expect { subject }.to change { Task.count }.by(-1)
      end
    end

    context '異常系' do
      context '存在しないタスクIDを指定した時' do
        let(:task_id) { 0 }

        it_behaves_like '存在しないリソース'

        it 'タスクを削除しない', :skip_subjct do
          expect { subject }.not_to change { Task.count }
        end
      end

      include_context 'ログインしていない時' do
        let(:task_id) { task.id }
      end

      context '他のユーザーのタスクを指定した時' do
        let!(:other_project) { create :project }
        let!(:other_task) { create :task, project: other_project }
        let(:task_id) { other_task.id }

        it_behaves_like '存在しないリソース'
      end
    end
  end
end
