class Api::TodosController < Api::BaseController
  def index
    @projects = current_user.projects.in_progress.order(id: :desc)
    @date = date_param
  end

  private

  def date_param
    params.require(:date)
  end
end
