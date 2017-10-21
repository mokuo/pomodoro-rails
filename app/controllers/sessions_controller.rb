class SessionsController < ApplicationController
  skip_before_action :restrict_access, except: :destroy

  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      login(user)
      redirect_to root_path, notice: 'ログインしました'
    else
      flash[:alert] = 'ユーザー名とパスワードが一致しません'
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_sessions_path, notice: 'ログアウトしました'
  end
end
