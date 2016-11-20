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
      redirect_to project_path(@project) 
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
    load_project
    @task = Task.find params[:id]
    if params[:owner_id]
      @task.owner_id = params[:owner_id]
      @task.save
    end

    if params[:due_date]
      @task.due_date = params[:due_date]
      @task.save
    end
    
    respond_to do |format|
      format.html {redirect_to project_path(@project)}
      format.js
    end 
  end

  def destroy
    @project = Project.find params[:project_id]
    @task = Task.find params[:id]
    @task.destroy
    redirect_to project_path(@project) 
  end
  private
  def task_params
    params.require(:task).permit(:name)
  end

  def load_project
    @project = Project.find params[:project_id]
  end
end
