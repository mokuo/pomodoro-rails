require 'rails_helper'

RSpec.describe 'Todos', type: :request do
  let(:user) { create :user }

  before do |example|
    login(user) unless example.metadata[:skip_login]
  end

  describe 'GET /todos' do
    subject { get '/todos' }
    let(:other_user) { create :user }
    let!(:project) { create :project, user: user }
    let!(:projects) { create_list :project, 3, user: user }
    let!(:stop_projects) { create_list :project, 3, user: user, stopped_at: DateTime.current }
    let!(:other_user_projects) { create_list :project, 2, user: other_user }
    let!(:task) { create :task, project: project, todo_on: Date.current }
    let!(:tasks) { create_list :task, 2, project: project, todo_on: Date.current }
    let!(:yesterday_tasks) { create_list :task, 2, project: project, todo_on: Date.yesterday }
    let!(:pomodoros) { create_list :pomodoro, 3, task: task }

    before { subject }

    context '正常系' do
      it '@projects にログインユーザーかつ進行中のプロジェクトのみ割り当てる' do
        expect(assigns(:projects).size).to eq 5 # others も加わる
      end
    end

    context '異常系' do
      include_context 'ログインしていない時'
    end
  end
end
