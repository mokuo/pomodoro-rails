class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :destroy]

  def index
    # TODO: フロントエンドの実装に入り次第、外す
    current_user = User.take
    @projects = current_user.projects.without_default
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
    if @project.destroy
      redirect_to projects_url, notice: 'プロジェクトが削除されました'
    else
      redirect_to projects_url, alert: @project.errors.full_messages.first
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
