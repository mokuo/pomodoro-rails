class Api::TasksController < Api::BaseController
  def create
    project = Project.find(params[:project_id])
    @task = project.tasks.create(task_params)
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
  end

  private

  def task_params
    params.require(:task).permit(:name, :todo_on, :done)
  end
end
