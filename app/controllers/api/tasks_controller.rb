class Api::TasksController < Api::BaseController
  def create
    project = Project.find(params[:project_id])
    @task = project.tasks.create(task_params)
  end

  private

  def task_params
    params.require(:task).permit(:name, :todo_on)
  end
end
