class Api::PomodorosController < Api::BaseController
  before_action :set_pomodoro, only: [:update, :destroy]

  def create
    task = current_user.tasks.find(params[:task_id])
    @pomodoro = task.pomodoros.create(pomodoro_params)
  end

  def update
    @pomodoro.update(pomodoro_params)
  end

  def destroy
    @pomodoro.destroy
  end

  private

  def pomodoro_params
    params.require(:pomodoro).permit(:box, :done)
  end

  def set_pomodoro
    @pomodoro = current_user.pomodoros.find(params[:id])
  end
end
