def login(user = create(:user))
  post '/sessions', params: { name: user.name, password: user.password }
end
