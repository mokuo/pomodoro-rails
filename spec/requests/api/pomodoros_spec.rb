require 'rails_helper'

RSpec.describe 'Api::Pomodoros', type: :request do
  include_context 'ログインしている'

  describe 'POST /api/v1/tasks/:task_id/pomodoros' do
    subject { post "/api/v1/tasks/#{task_id}/pomodoros", params: params, headers: headers }
    let!(:task) { create :task }
    let(:headers) { {
      'ACCEPT': 'application/json',
      'CONTENT_TYPE': 'application/json'
    } }

    before do |example|
      subject unless example.metadata[:skip_before]
    end

    context '正常系' do
      let(:task_id) { task.id }
      let(:params) { '{ "box": "square" }' }

      it_behaves_like '処理成功'

      it 'ポモドーロを新規作成する', :skip_before do
        expect { subject }.to change { Pomodoro.count }.by(1)
      end

      it 'ポモドーロIDを返す' do
        expect(response.body).to be_json_eql(Pomodoro.last.id).at_path('pomodoro/id')
      end

      it 'box を返す' do
        expect(response.body).to be_json_eql('square'.to_json).at_path('pomodoro/box')
      end

      it 'done を返す' do
        expect(response.body).to be_json_eql(false).at_path('pomodoro/done')
      end

      it 'タスクIDを返す' do
        expect(response.body).to be_json_eql(task_id).at_path('pomodoro/task_id')
      end
    end

    context '異常系' do
      context 'パラメーターを指定しない時' do
        let(:task_id) { task.id }
        let(:params) { '' }

        it_behaves_like 'パラメーター不足'

        it 'ポモドーロが作成されない', :skip_before do
          expect { subject }.not_to change { Pomodoro.count }
        end
      end

      context '存在しないタスクIDを指定した時' do
        let(:task_id) { 0 }
        let(:params) { '{ "box": "square" }' }

        it_behaves_like '存在しないリソース'

        it 'ポモドーロが作成されない', :skip_before do
          expect { subject }.not_to change { Pomodoro.count }
        end
      end

      context 'box に空文字を指定した時' do
        let(:task_id) { task.id }
        let(:params) { '{ "box": "" }' }

        it_behaves_like 'バリデーションエラー'

        it 'ポモドーロが作成されない', :skip_before do
          expect { subject }.not_to change { Pomodoro.count }
        end

        it 'バリデーションエラーメッセージを返す' do
          expect(response.body).to be_json_eql('ボックスを入力してください'.to_json).at_path('error/messages/0')
        end
      end
    end
  end
end
