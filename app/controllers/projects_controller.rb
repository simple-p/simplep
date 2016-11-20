class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :show, :update, :destroy]
  def index
    @project = Project.all.order("created_at DESC")
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.create project_params
    binding.pry
    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path }
        format.json { head :no_content }
        format.js
      else
        format.json { render json:@project.errors.full_messages,
                      status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def show
  end

  def update
    respond_to do |format|
      if @project.update project_params
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @project.errors.full_messages,
                      status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_path }
      format.json { head :no_content }
    end
  end

  private

  def set_project
    @project = Project.find params[:id]
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
