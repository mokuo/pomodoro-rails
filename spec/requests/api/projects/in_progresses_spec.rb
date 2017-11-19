require 'rails_helper'

RSpec.describe 'Api::Projects::InProgresses', type: :request do
  include_context 'ログインしている'

  describe 'GET /api/v1/projects/in_progresses' do
    subject { get '/api/v1/projects/in_progresses', headers: headers }
    let(:headers) { { 'ACCEPT': 'application/json' } }

    let!(:projects) { create_list :project, 2, user: user }
    let!(:stopped_project) { create :project, user: user, name: '停止中プロジェクト', stopped_at: DateTime.current }

    before { subject }

    it_behaves_like '処理成功'

    it 'プロジェクトIDを返す' do
      expect(response.body).to have_json_type(Integer).at_path('projects/0/id')
    end

    it 'プロジェクト名を返す' do
      expect(response.body).to have_json_type(String).at_path('projects/0/name')
    end

    it '進行中のプロジェクトのみ返す' do
      p Project.all
      expect(response.body).to have_json_size(3).at_path('projects')
    end
  end
end
