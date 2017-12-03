require 'rails_helper'

RSpec.describe 'Projects::Stops', type: :request do
  before do |example|
    login(user) unless example.metadata[:skip_login]
  end
  let(:user) { create :user }

  describe 'PATCH /projects/:project_id/stop' do
    subject { patch "/projects/#{project.id}/stop" }

    before do |example|
      subject unless example.metadata[:skip_subject]
    end

    context '正常系' do
      let!(:project) { create :project, user: user }

      it 'プロジェクトを停止する' do
        expect { project.reload }.to change { project.stopped_at? }.from(false).to(true)
      end

      it 'プロジェクト一覧画面に遷移する' do
        expect(response).to redirect_to projects_url
      end
    end

    context '異常系' do
      include_context 'ログインしていない時' do
        let!(:project) { create :project, user: user }
      end

      include_context '他のユーザーのリソースを指定した時' do
        let!(:project) { create :project }
      end
    end
  end

  describe 'DELETE /projects/:project_id/stop' do
    subject { delete "/projects/#{project.id}/stop" }

    before do |example|
      subject unless example.metadata[:skip_subject]
    end

    context '正常系' do
      let!(:project) { create :project, stopped_at: DateTime.current, user: user }

      it 'プロジェクトを再開する' do
        expect { project.reload }.to change { project.stopped_at? }.from(true).to(false)
      end

      it 'プロジェクト一覧画面に遷移する' do
        expect(response).to redirect_to projects_url
      end
    end

    context '異常系' do
      include_context 'ログインしていない時' do
        let!(:project) { create :project, stopped_at: DateTime.current, user: user }
      end

      include_context '他のユーザーのリソースを指定した時' do
        let!(:project) { create :project, stopped_at: DateTime.current }
      end
    end
  end
end
