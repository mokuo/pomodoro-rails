class Api::TodosController < Api::BaseController
  def index
    @date = date_param
    @projects = current_user.projects.in_progress.order(id: :desc)
  end

  private

  def date_param
    params.require(:date)
  end
end
