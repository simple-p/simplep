class DashboardsController < ApplicationController
  helper_method :load_project
  def index
    @tasks = current_user.tasks
    @myProjects = current_team.projects
    @task_news = current_user.activities 
  end

  def load_project(task)
    @project = Project.find task.project_id
  end
end
