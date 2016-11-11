class TasksController < ApplicationController
  def new 
    @project = Project.find(params[:project_id])
    @task = Task.new
  end

  def index

  end

  def create
    load_project
    @task = @project.tasks.build task_params
    
    if @task.save
      redirect_to root_path 
    else
      redirect_to new_projects_task_path(@project) 
    end

  end

  private
  def task_params
    params.require(:task).permit(:name)
  end

  def load_project
    @project = Project.find params[:project_id]
  end
end
