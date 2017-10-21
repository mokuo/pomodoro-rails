class SessionsController < ApplicationController
  def new
  end

  def create
    if User.find_by(name: params[:name]).tapp.try(:authenticate, params[:password]).tapp
      redirect_to root_path, notice: 'ログインしました'
    else
      flash[:alert] = 'ユーザー名とパスワードが一致しません'
      render :new
    end
  end
end
