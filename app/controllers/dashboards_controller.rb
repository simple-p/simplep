class DashboardsController < ApplicationController
  helper_method :load_project
  def index
    @tasks = current_user.tasks
    @task_news = current_user.activities
    if current_team
      @myProjects = current_team.projects
    else
      @myProjects = nil
    end
  end

  def load_project(task)
    @project = Project.find task.project_id
  end
end
