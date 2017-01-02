class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :show, :update, :destroy]
  def index
    if current_team != nil
      @project = current_team.my_team_project
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.create project_params
    @project.team = current_team
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
    if params[:completed] == "0"
      @tasks = @project.tasks.where("completed_at IS NULL")
    elsif params[:completed] == "1"
      @tasks = @project.tasks.where("completed_at IS NOT NULL")
    else
      @tasks = @project.tasks.order('position desc')
    end
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
    params.require(:project).permit(:name, :current_team_id)
  end
end
