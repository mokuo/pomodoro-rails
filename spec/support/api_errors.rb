shared_examples '処理成功' do
  it 'ステータスコード 200 を返す' do
    expect(response).to have_http_status 200
  end

  it 'エラーコード 0 を返す' do
    expect(response.body).to be_json_eql(0).at_path('error/code')
  end
end

shared_examples 'パラメーター不足' do
  it 'ステータスコード 200 を返す' do
    expect(response).to have_http_status 200
  end

  it 'エラーコード 400 を返す' do
    expect(response.body).to be_json_eql(400).at_path('error/code')
  end

  it 'エラーメッセージを返す' do
    expect(response.body).to be_json_eql('実行に必要なパラメーターが送信されていません'.to_json).at_path('error/messages/0')
  end
end

shared_examples '存在しないリソース' do
  it 'ステータスコード 200 を返す' do
    expect(response).to have_http_status 200
  end

  it 'エラーコード 401 を返す' do
    expect(response.body).to be_json_eql(401).at_path('error/code')
  end

  it 'エラーメッセージを返す' do
    expect(response.body).to be_json_eql('指定されたリソースが見つかりません'.to_json).at_path('error/messages/0')
  end
end

shared_examples 'バリデーションエラー' do
  it 'ステータスコード 200 を返す' do
    expect(response).to have_http_status 200
  end

  it 'エラーコード 402 を返す' do
    expect(response.body).to be_json_eql(402).at_path('error/code')
  end
end

shared_examples '引数エラー' do
  it 'ステータスコード 200 を返す' do
    expect(response).to have_http_status 200
  end

  it 'エラーコード 403 を返す' do
    expect(response.body).to be_json_eql(403).at_path('error/code')
  end

  it 'エラーメッセージを返す' do
    expect(response.body).to be_json_eql('引数が間違っています'.to_json).at_path('error/messages/0')
  end
end
