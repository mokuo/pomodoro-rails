class Api::PomodorosController < Api::BaseController
  def create
    task = Task.find(params[:task_id])
    @pomodoro = task.pomodoros.create(pomodoro_params)
  end

  private

  def pomodoro_params
    params.require(:pomodoro).permit(:box)
  end
end
