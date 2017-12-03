class Api::TasksController < Api::BaseController
  before_action :set_task, only: [:update, :destroy]

  def create
    project = current_user.projects.find(params[:project_id])
    @task = project.tasks.create(task_params)
  end

  def update
    @task.update(task_params)
  end

  def destroy
    @task.destroy
  end

  private

  def task_params
    params.require(:task).permit(:name, :todo_on, :done)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
