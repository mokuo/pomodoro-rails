require 'rails_helper'

RSpec.describe 'Api::Tasks', type: :request do
  include_context 'ログインしている'

  describe 'POST /api/v1/projects/:project_id/tasks' do
    subject { post "/api/v1/projects/#{project_id}/tasks", params: params, headers: headers }
    let(:headers) { {
      'ACCEPT': 'application/json',
      'CONTENT_TYPE': 'application/json'
    } }
    let!(:project) { create :project }

    before { subject }

    context '正常系' do
      let(:project_id) { project.id }
      let(:params) { '{ "task": { "name": "test_task", "todo_on": "2017-11-19" } }' }

      it_behaves_like '処理成功'

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
        let(:project_id) { project.id }
        let(:params) { {} }

        it_behaves_like 'パラメーター不足'
      end

      context '存在しないプロジェクトIDを指定した時' do
        let(:project_id) { 0 }
        let(:params) { '{ "task": { "name": "test_task", "todo_on": "2017-11-19" } }' }

        it_behaves_like '存在しないリソース'
      end

      context 'バリデーションエラーの時' do
        let(:project_id) { project.id }
        let(:params) { '{ "task": { "name": "", "todo_on": "" } }' }

        it_behaves_like 'バリデーションエラー'

        it 'name のバリデーションエラーを返す' do
          expect(response.body).to be_json_eql('タスク名を入力してください'.to_json).at_path('error/messages/0')
        end

        it 'todo_on のバリデーションエラーを返す' do
          expect(response.body).to be_json_eql('日付を入力してください'.to_json).at_path('error/messages/1')
        end
      end
    end
  end
end