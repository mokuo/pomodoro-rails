class Api::TodosController < Api::BaseController
  def index
    @projects = current_user.projects.eager_load(tasks: :pomodoros).where(tasks: { todo_on: date_params })
  end

  private

  def date_params
    params.require(:date)
  end
end
