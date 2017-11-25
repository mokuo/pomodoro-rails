require 'rails_helper'

RSpec.describe 'Projects::Stops', type: :request do
  before do |example|
    login unless example.metadata[:skip_login]
  end

  describe 'PATCH /projects/:project_id/stop' do
    subject { patch "/projects/#{project.id}/stop" }
    let!(:project) { create :project }

    before { subject }

    context '正常系' do
      it 'プロジェクトを停止する' do
        expect { project.reload }.to change { project.stopped_at? }.from(false).to(true)
      end

      it 'プロジェクト一覧画面に遷移する' do
        expect(response).to redirect_to projects_url
      end
    end

    context '異常系' do
      include_context 'ログインしていない時'
    end
  end

  describe 'DELETE /projects/:project_id/stop' do
    subject { delete "/projects/#{project.id}/stop" }
    let!(:project) { create :project, stopped_at: DateTime.current }

    before { subject }

    context '正常系' do
      it 'プロジェクトを再開する' do
        expect { project.reload }.to change { project.stopped_at? }.from(true).to(false)
      end

      it 'プロジェクト一覧画面に遷移する' do
        expect(response).to redirect_to projects_url
      end
    end

    context '異常系' do
      include_context 'ログインしていない時'
    end
  end
end
