class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = current_user.projects.new(project_params)

    if @project.save
      redirect_to projects_url, notice: 'プロジェクトが作成されました'
    else
      render :new
    end
  end

  def update
    if @project.update(project_params)
      redirect_to projects_url, notice: 'プロジェクトが更新されました'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
      redirect_to projects_url, notice: 'プロジェクトが削除されました'
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
