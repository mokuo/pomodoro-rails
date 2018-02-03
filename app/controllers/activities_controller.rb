class ActivitiesController < ApplicationController
  def index
    @projects = current_user.projects.in_progress.order(id: :desc)
  end
end
