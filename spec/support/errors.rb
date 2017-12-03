shared_context '他のユーザーのリソースを指定した時' do
  it 'RecordNotFound エラーになる', :skip_subject do
    expect { subject }.to raise_error ActiveRecord::RecordNotFound
  end
end
