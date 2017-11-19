require 'rails_helper'

RSpec.describe 'Api::Projects', type: :request do
  include_context 'ログインしている'

  describe 'GET /api/v1/todos' do
    subject { get '/api/v1/todos', params: params, headers: headers }
    let(:params) { { date: today.to_s } }
    let(:today) { Date.today }
    let(:headers) { { 'ACCEPT': 'application/json' } }

    let!(:project) { create :project, user: user }
    let!(:other_project) { create :project, user: user }
    let!(:task1) { create :task, project: project, todo_on: today }
    let!(:task2) { create :task, project: project, todo_on: today }
    let!(:other_task1) { create :task, project: project, todo_on: Date.yesterday }
    let!(:other_task2) { create :task, project: other_project, todo_on:  Date.yesterday }
    let!(:pomodoros) { create_list :pomodoro, 2, task: task1 }

    before { subject }

    it_behaves_like '処理成功'

    it 'プロジェクトの属性を返す' do
      expect(response.body).to have_json_type(Integer).at_path('projects/0/id')
      expect(response.body).to have_json_type(String).at_path('projects/0/name')
      expect(response.body).to have_json_type(Array).at_path('projects/0/tasks')
    end

    it 'タスクの属性を返す' do
      expect(response.body).to have_json_type(Integer).at_path('projects/0/tasks/0/id')
      expect(response.body).to have_json_type(String).at_path('projects/0/tasks/0/name')
      expect(response.body).to have_json_type(FalseClass).at_path('projects/0/tasks/0/done')
      expect(response.body).to have_json_type(Array).at_path('projects/0/tasks/0/pomodoros')
    end

    it 'ポモドーロの属性を返す' do
      expect(response.body).to have_json_type(Integer).at_path('projects/0/tasks/0/pomodoros/0/id')
      expect(response.body).to have_json_type(String).at_path('projects/0/tasks/0/pomodoros/0/box')
      expect(response.body).to have_json_type(FalseClass).at_path('projects/0/tasks/0/pomodoros/0/done')
    end

    it '指定された日付のタスクが紐づいたプロジェクトのみ返す' do
      expect(response.body).to have_json_size(1).at_path('projects')
    end

    it '指定された日付のタスクのみ返す' do
      expect(response.body).to have_json_size(2).at_path('projects/0/tasks')
    end

    it '正しい数のポモドーロを返す' do
      expect(response.body).to have_json_size(2).at_path('projects/0/tasks/0/pomodoros')
    end
  end
end