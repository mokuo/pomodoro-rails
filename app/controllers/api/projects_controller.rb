class Api::ProjectsController < Api::BaseController
  def index
    # TODO: フロントエンドの実装に入り次第、外す
    current_user = User.take
    @projects = current_user.projects
  end
end
