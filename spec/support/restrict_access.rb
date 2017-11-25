shared_examples 'ログイン画面に遷移する' do
  it { expect(response).to redirect_to new_sessions_path }
end
