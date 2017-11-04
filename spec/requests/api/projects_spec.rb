require 'rails_helper'

RSpec.describe 'Api::Projects', type: :request do
  include_context 'ログインしている'

  describe 'GET /api/v1/projects' do
    subject { get '/api/v1/projects', headers: headers }
    let(:headers) { { 'ACCEPT': 'application/json' } }
    let!(:projects) { create_list :project, 2, user: user }

    before { subject }

    it '@projects にプロジェクトを割り当てる' do
      expect(assigns(:projects)).to eq projects
    end

    it 'ステータスコード 200 を返す' do
      expect(response).to have_http_status :ok
    end

    it 'エラーコード 0 を返す' do
      expect(response.body).to be_json_eql(0).at_path('error/code')
    end

    it 'id を含む' do
      expect(response.body).to have_json_path('projects/1/id')
      expect(response.body).to have_json_type(Integer).at_path('projects/1/id')
    end

    it 'name を含む' do
      expect(response.body).to have_json_path('projects/1/name')
      expect(response.body).to have_json_type(String).at_path('projects/1/name')
    end

    it 'stopped_at を含む' do
      expect(response.body).to have_json_path('projects/1/stopped_at')
    end

    it '正しい数のプロジェクトを含む' do
      expect(response.body).to have_json_size(2).at_path('projects')
    end
  end
end
