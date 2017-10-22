shared_context 'ログインしている' do
  let!(:user) { create :user, name: name, password: 'password' }
  let(:name) { FFaker::Name.name }
  let(:params) { { name: name, password: 'password' } }

  before { post '/sessions', params: params }
end
