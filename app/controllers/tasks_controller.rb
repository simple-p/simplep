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
    @task.owner = current_user
    
    if @task.save
      track_activity @project, @task
      redirect_to root_path 
    else
      redirect_to new_projects_task_path(@project) 
    end

  end

  def show
    load_project
    @task = Task.find params[:id]
    
    respond_to do |format|
      format.html do
       redirect_to project_path(@project) 
      end

      format.js
    end


  end

  def update

  end

  def destroy

  end
  private
  def task_params
    params.require(:task).permit(:name)
  end

  def load_project
    @project = Project.find params[:project_id]
  end
end
