require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'GET /sessions/new' do
    subject { get '/sessions/new' }

    it 'ログイン画面を表示する' do
      subject
      expect(response).to render_template :new
    end
  end

  describe 'POST /sessions' do
    subject { post '/sessions', params: params }
    let!(:user) { create :user, name: 'testuser', password: 'password' }

    before { subject }

    context '正常系' do
      let(:params) { { name: 'testuser', password: 'password' } }

      it 'ログインする' do
        expect(session[:user_id]).to eq user.id
      end

      it 'flash メッセージを設定する' do
        expect(flash[:notice]).to eq 'ログインしました'
      end

      it 'トップ画面に遷移する' do
        expect(response).to redirect_to root_path
      end
    end

    context '異常系' do
      shared_examples 'ログインに失敗する' do
        it 'ログインしない' do
          expect(session[:user_id]).to eq nil
        end

        it 'flash メッセージを設定する' do
          expect(flash[:alert]).to eq 'ユーザー名とパスワードが一致しません'
        end

        it 'ログイン画面を表示する' do
          expect(response).to render_template :new
        end
      end

      context 'ユーザー名が間違っている時' do
        let(:params) { { name: 'wronguser', password: 'password' } }

        it_behaves_like 'ログインに失敗する'
      end

      context 'パスワードが間違っている時' do
        let(:params) { {name: 'testuser', password: 'wrongpass' } }

        it_behaves_like 'ログインに失敗する'
      end
    end
  end

  describe 'DELETE /sessions' do
    subject { delete '/sessions' }

    context '正常系' do
      before do
        login
        subject
      end

      it 'ログアウトする' do
        expect(session[:user_id]).to be_nil
      end

      it 'ログイン画面に遷移する' do
        expect(response).to redirect_to new_sessions_path
      end
    end

    context '異常系' do
      context 'ログインしていない時' do
        before { subject }

        it_behaves_like 'ログイン画面に遷移する'
      end
    end
  end
end
