class Api::Projects::InProgressesController < Api::BaseController
  def index
    @projects = Project.in_progress
  end
end
