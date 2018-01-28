require 'rails_helper'

RSpec.describe 'Activities', type: :request do
  before do |example|
    login unless example.metadata[:skip_login]
  end

  describe 'GET /todos' do
    subject { get '/todos' }

    before { subject }

    context '正常系' do
      it 'アクティビティ在庫シートを表示する' do
        expect(response).to render_template :index
      end
    end

    context '異常系' do
      include_context 'ログインしていない時'
    end
  end
end
