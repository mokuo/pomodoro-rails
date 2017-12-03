require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  let(:user) { create :user }

  before do |example|
    login(user) unless example.metadata[:skip_login]
  end

  describe 'GET /projects' do
    subject { get '/projects' }
    let!(:projects) { create_list :project, 2, user: user }

    before do
      create_list :project, 2
      subject
    end

    context '正常系' do
      it '@projects にログインユーザーのプロジェクトのみ割り当てる' do
        expect(assigns(:projects)).to eq projects
      end

      it 'プロジェクト一覧画面を表示する' do
        expect(response).to render_template :index
      end
    end

    context '異常系' do
      include_context 'ログインしていない時'
    end
  end

  describe 'GET /projects/new' do
    subject { get '/projects/new' }

    before { subject }

    context '正常系' do
      it '@project に新しいプロジェクトを割り当てる' do
        expect(assigns(:project)).to be_a_new Project
      end

      it 'プロジェクト新規作成画面を表示する' do
        expect(response).to render_template :new
      end
    end

    context '異常系' do
      include_context 'ログインしていない時'
    end
  end

  describe 'GET /projects/:id/edit' do
    subject { get "/projects/#{project.id}/edit" }

    before do |example|
      subject unless example.metadata[:skip_subject]
    end

    context '正常系' do
      let(:project) { create :project, user: user }

      it '@project にプロジェクトを割り当てる' do
        expect(assigns(:project)).to eq project
      end

      it 'プロジェクト編集画面表示する' do
        expect(response).to render_template :edit
      end
    end

    context '異常系' do
      include_context 'ログインしていない時' do
        let(:project) { create :project, user: user }
      end

      include_context '他のユーザーのリソースを指定した時' do
        let(:project) { create :project }
      end
    end
  end

  describe 'POST /projects' do
    subject { post '/projects', params: params }

    before do |example|
      subject unless example.metadata[:skip_subject]
    end

    context '正常系' do
      let(:params) { { project: { name: 'テストプロジェクト' } } }

      it 'プロジェクトを新規作成する', :skip_subject do
        expect { subject }.to change { Project.count }.by(1)
      end

      it 'flash メッセージを設定する' do
        expect(flash[:notice]).to eq 'プロジェクトが作成されました'
      end

      it 'プロジェクト一覧画面に遷移する' do
        expect(response).to redirect_to projects_url
      end
    end

    context '異常系' do
      context 'プロジェクト名が空の時' do
        let(:params) { { project: { name: '' } } }

        it 'プロジェクトを新規作成しない' do
          expect { subject }.not_to change { Project.count }
        end

        it 'プロジェクト新規作成画面を表示する' do
          expect(response).to render_template :new
        end
      end

      include_context 'ログインしていない時' do
        let(:params) { { project: { name: 'テストプロジェクト' } } }
      end
    end
  end

  describe 'PATCH /projects/:id' do
    subject { patch "/projects/#{project.id}", params: params }

    before do |example|
      subject unless example.metadata[:skip_subject]
    end

    context '正常系' do
      let!(:project) { create :project, name: 'old name', user: user }
      let(:params) { { project: { name: 'new name' } } }

      it 'プロジェクト名を変更する' do
        expect { project.reload }.to change { project.name }.from('old name').to('new name')
      end

      it 'flash メッセージを設定する' do
        expect(flash[:notice]).to eq 'プロジェクトが更新されました'
      end

      it 'プロジェクト一覧画面に遷移する' do
        expect(response).to redirect_to projects_url
      end
    end

    context '異常系' do
      context 'プロジェクト名が空の時' do
        let!(:project) { create :project, name: 'old name', user: user }
        let(:params) { { project: { name: '' }  } }

        it 'プロジェクト名を変更しない' do
          expect { project.reload }.not_to change { project.name }
        end

        it 'プロジェクト編集画面に遷移する' do
          expect(response).to render_template :edit
        end
      end

      include_context 'ログインしていない時' do
        let!(:project) { create :project, name: 'old name', user: user }
        let(:params) { { project: { name: 'new name' } } }
      end

      include_context '他のユーザーのリソースを指定した時' do
        let!(:project) { create :project, name: 'old name' }
        let(:params) { { project: { name: 'new name' } } }
      end
    end
  end

  describe 'DELETE /projects/:id' do
    subject { delete "/projects/#{project.id}" }

    before do |example|
      subject unless example.metadata[:skip_subject]
    end

    context '正常系' do
      let!(:project) { create :project, user: user }

      it 'プロジェクトを削除する', :skip_subject do
        expect { subject }.to change { Project.count }.by(-1)
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
end
