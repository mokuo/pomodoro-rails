require 'rails_helper'

RSpec.describe 'Api::Projects', type: :request do
  before do |example|
    login(user) unless example.metadata[:skip_login]
  end
  let(:user) { create :user }

  describe 'GET /api/v1/projects' do
    subject { get '/api/v1/projects', headers: headers }
    let(:headers) { { 'ACCEPT': 'application/json' } }
    let!(:project1) { create :project, user: user, name: 'プロジェクト1' }
    let!(:project2) { create :project, user: user, name: 'プロジェクト2', stopped_at: DateTime.current }
    let!(:other_project) { create :project, user: other_user }
    let(:other_user) { create :user }

    before { subject }

    context '正常系' do
      it_behaves_like '処理成功'

      it '1つ目のプロジェクトを返す' do
        expect(response.body).to be_json_eql(project1.id).at_path('projects/0/id')
        expect(response.body).to be_json_eql(project1.name.to_json).at_path('projects/0/name')
        expect(response.body).to be_json_eql(project1.stopped_at.to_json).at_path('projects/0/stopped_at')
      end

      it '2つ目のプロジェクトを返す' do
        expect(response.body).to be_json_eql(project2.id).at_path('projects/1/id')
        expect(response.body).to be_json_eql(project2.name.to_json).at_path('projects/1/name')
        expect(response.body).to be_json_eql(project2.stopped_at.to_json).at_path('projects/1/stopped_at')
      end

      it 'ログインしているユーザーのプロジェクトのみを返す' do
        expect(response.body).to have_json_size(2).at_path('projects')
      end
    end

    context '異常系' do
      include_context 'ログインしていない時'
    end
  end
end
