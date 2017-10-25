shared_context 'ログインしている' do
  let!(:user) { create :user, name: user_name, password: 'password' }
  let(:user_name) { FFaker::Name.name }
  let(:user_params) { { name: user_name, password: 'password' } }

  before { post '/sessions', params: user_params }
end
