shared_context 'ログインしていない時' do
  it 'ログイン画面に遷移する', :skip_login do
    expect(response).to redirect_to new_sessions_path
  end
end
