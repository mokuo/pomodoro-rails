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
      shared_examples 'ポモドーロが作成されない' do
        it :skip_before do
          expect { subject }.not_to change { Pomodoro.count }
        end
      end

      context 'パラメーターを指定しない時' do
        let(:task_id) { task.id }
        let(:params) { '' }

        it_behaves_like 'パラメーター不足'

        it_behaves_like 'ポモドーロが作成されない'
      end

      context '存在しないタスクIDを指定した時' do
        let(:task_id) { 0 }
        let(:params) { '{ "box": "square" }' }

        it_behaves_like '存在しないリソース'

        it_behaves_like 'ポモドーロが作成されない'
      end

      context 'box に空文字を指定した時' do
        let(:task_id) { task.id }
        let(:params) { '{ "box": "" }' }

        it_behaves_like 'バリデーションエラー'

        it_behaves_like 'ポモドーロが作成されない'

        it 'バリデーションエラーメッセージを返す' do
          expect(response.body).to be_json_eql('ボックスを入力してください'.to_json).at_path('error/messages/0')
        end
      end

      context 'box に誤った値を指定した時' do
        let(:task_id) { task.id }
        let(:params) { '{ "box": "hoge" }' }

        it_behaves_like '引数エラー'

        it_behaves_like 'ポモドーロが作成されない'
      end
    end
  end

  describe 'PATCH /api/v1/pomodoros/:id' do
    subject { patch "/api/v1/pomodoros/#{pomodoro_id}", params: params, headers: headers }
    let!(:pomodoro) { create :pomodoro }
    let(:headers) { {
      'ACCEPT': 'application/json',
      'CONTENT_TYPE': 'application/json'
    } }

    before { subject }

    context '正常系' do
      let(:pomodoro_id) { pomodoro.id }
      let(:params) { '{ "pomodoro": { "done": true } }' }

      it_behaves_like '処理成功'

      it 'ポモドーロを更新する' do
        expect { pomodoro.reload }.to change { pomodoro.done }.from(false).to(true)
      end

      it 'ポモドーロIDを返す' do
        expect(response.body).to be_json_eql(pomodoro.id).at_path('pomodoro/id')
      end

      it 'box を返す' do
        expect(response.body).to be_json_eql('square'.to_json).at_path('pomodoro/box')
      end

      it 'done を返す' do
        expect(response.body).to be_json_eql(true).at_path('pomodoro/done')
      end

      it 'タスクIDを返す' do
        expect(response.body).to be_json_eql(pomodoro.task.id).at_path('pomodoro/task_id')
      end
    end

    context '異常系' do
      context 'パラメーターがない時' do
        let(:pomodoro_id) { pomodoro.id }
        let(:params) { '' }

        it_behaves_like 'パラメーター不足'
      end

      context '存在しないポモドーロIDを指定した時' do
        let(:pomodoro_id) { 0 }
        let(:params) { '{ "pomodoro": { "done": true } }' }

        it_behaves_like '存在しないリソース'
      end

      context 'done が空文字の時' do
        let(:pomodoro_id) { pomodoro.id }
        let(:params) { '{ "pomodoro": { "done": "" } }' }

        it_behaves_like 'バリデーションエラー'

        it 'バリデーションエラーメッセージを返す' do
          expect(response.body).to be_json_eql('ポモドーロ完了は一覧にありません'.to_json).at_path('error/messages/0')
        end
      end
    end
  end

  describe 'DELETE /api/v1/pomodoros/:id' do
    subject { delete "/api/v1/pomodoros/#{pomodoro_id}", headers: headers }
    let!(:pomodoro) { create :pomodoro }
    let(:headers) { {
      'ACCEPT': 'application/json'
    } }

    before do |example|
      subject unless example.metadata[:skip_before]
    end

    context '正常系' do
      let(:pomodoro_id) { pomodoro.id }

      it_behaves_like '処理成功'

      it 'ポモドーロを削除する', :skip_before do
        expect { subject }.to change { Pomodoro.count }.by(-1)
      end
    end
  end
end
