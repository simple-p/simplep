class DashboardsController < ApplicationController
  def index
    @tasks = current_user.tasks
    @team = current_user.current_team
  end
end
