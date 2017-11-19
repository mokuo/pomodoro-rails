shared_examples '処理成功' do
  it 'ステータスコード 200 を返す' do
    expect(response).to have_http_status 200
  end

  it 'エラーコード 0 を返す' do
    expect(response.body).to be_json_eql(0).at_path('error/code')
  end
end
