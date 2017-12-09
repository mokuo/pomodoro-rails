class TodosController < ApplicationController
  def index
    @projects = current_user.projects.in_progress.order(id: :desc)
    @todos = current_user.projects.eager_load(tasks: :pomodoros).where(tasks: { todo_on: Date.current })
  end
end
