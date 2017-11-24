class Api::ProjectsController < Api::BaseController
  def index
    @projects = current_user.projects.without_default
  end
end
