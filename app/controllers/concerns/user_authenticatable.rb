concern :UserAuthenticatable do
  included do
    helper_method :logged_in?
  end

  private

  def restrict_access
    redirect_to new_sessions_path unless logged_in?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logout
    @current_user = session[:user_id] = nil
  end
end
