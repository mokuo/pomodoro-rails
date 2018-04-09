class Projects::StopsController < ApplicationController
  before_action :set_project, only: [:update, :destroy]

  # TODO: 戻り値が false の処理を追加する
  def update
    @project.stop
    redirect_to projects_url, notice: 'プロジェクトが停止されました'
  end

  def destroy
    @project.restart
    redirect_to projects_url, notice: 'プロジェクトが再開されました'
  end

  private

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end
end
