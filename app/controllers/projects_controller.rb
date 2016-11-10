class ProjectsController < ApplicationController
  def new 
    @project = Project.new
  end

  def create
    @project = Project.new project_params
    
    if @project.save
      redirect_to root_path 
    else
      redirect_to new_project_path 
    end

  end

  private
  def project_params
    params.require(:project).permit(:name)
  end
end
