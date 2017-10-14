require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  describe 'GET /projects' do
    subject { get '/projects' }
    let!(:projects) { create_list :project, 2 }

    before { subject }

    it '@projects にプロジェクトを割り当てる' do
      expect(assigns(:projects)).to eq projects
    end

    it 'プロジェクト一覧画面を表示する' do
      expect(response).to render_template :index
    end
  end

  describe 'GET /projects/new' do
    subject { get '/projects/new' }

    before { subject }

    it '@project に新しいプロジェクトを割り当てる' do
      expect(assigns(:project)).to be_a_new Project
    end

    it 'プロジェクト新規作成画面を表示する' do
      expect(response).to render_template :new
    end
  end

  describe 'GET /projects/:id/edit' do
    subject { get "/projects/#{project.id}/edit" }
    let(:project) { create :project }

    before { subject }

    it '@project にプロジェクトを割り当てる' do
      expect(assigns(:project)).to eq project
    end

    it 'プロジェクト編集画面表示する' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST /projects' do
    subject { post '/projects', params: params }
    # TODO: ログイン機能を実装したら、外す
    let!(:user) { create :user }

    context '正常系' do
      let(:params) { { project: { name: 'テストプロジェクト' } } }

      it 'プロジェクトを新規作成する' do
        expect { subject }.to change { Project.count }.by(1)
      end

      it 'flash メッセージを設定する' do
        subject
        expect(flash[:notice]).to eq 'プロジェクトが作成されました'
      end

      it 'プロジェクト一覧画面に遷移する' do
        subject
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
          subject
          expect(response).to render_template :new
        end
      end
    end
  end

  describe 'PATCH /projects/:id' do
    subject { patch "/projects/#{project.id}", params: params }
    let!(:project) { create :project, name: 'old name' }

    before { subject }

    context '正常系' do
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
        let(:params) { { project: { name: '' }  } }

        it 'プロジェクト名を変更しない' do
          expect { project.reload }.not_to change { project.name }
        end

        it 'プロジェクト編集画面に遷移する' do
          expect(response).to render_template :edit
        end
      end
    end
  end

  describe 'DELETE /projects/:id' do
    subject { delete "/projects/#{project.id}" }
    let!(:project) { create :project }

    it 'プロジェクトを削除する' do
      expect { subject }.to change { Project.count }.by(-1)
    end

    it 'プロジェクト一覧画面に遷移する' do
      subject
      expect(response).to redirect_to projects_url
    end
  end
end
