class TasksController < ApplicationController
  def new 
    @project = Project.find(params[:project_id])
    @task = Task.new
  end
end
