class Projects::StopsController < ApplicationController
  before_action :set_project, only: [:update, :destroy]

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
    @project = Project.find(params[:project_id])
  end
end
