class Api::TodosController < Api::BaseController
  def index
    # TODO: フロントエンドの実装に入り次第、外す
    current_user = User.take
    @projects = current_user.projects.eager_load(tasks: :pomodoros).where(tasks: { todo_on: params[:date] })
  end
end
