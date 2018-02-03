require 'rails_helper'

RSpec.describe 'Activities', type: :request do
  let(:user) { create :user }

  before do |example|
    login(user) unless example.metadata[:skip_login]
  end

  describe 'GET /todos' do
    subject { get '/todos' }
    let!(:project) { create :project, user: user }
    let!(:stopped_project) { create :project, user: user, stopped_at: Date.current }
    let(:default_projct) { user.projects.find_by(name: Constants::DEFAULT_PROJECT_NAME) }
    let(:other_user) { create :user }
    let!(:other_project) { create :project, user: other_user }

    before { subject }

    context '正常系' do
      it 'ログインユーザーかつ進行中のプロジェクトを ID の降順で割り当てる' do
        expect(assigns(:projects)).to eq [project, default_projct]
      end

      it 'アクティビティ在庫シートを表示する' do
        expect(response).to render_template :index
      end
    end

    context '異常系' do
      include_context 'ログインしていない時'
    end
  end
end
