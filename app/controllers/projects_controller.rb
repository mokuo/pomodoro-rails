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
    @project = Project.new(project_params)

    # TODO: ログイン機能を実装したら、current_user で project を作成する
    @project.user = User.take

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
