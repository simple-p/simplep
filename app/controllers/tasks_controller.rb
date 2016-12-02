class TasksController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @task = Task.new
  end

  def search
      @search = Task.search(params[:q])
      @tasks = @search.result
  end

  def sort
    params[:ids].each_with_index do |id, index|
      Task.where(id: id).update(position: index + 1)
    end

    render nothing: true
  end

  def index
    if current_user
      @tasks = current_user.tasks.order('position')
    end
  end

  def create
    load_project
    @task = @project.tasks.build task_params
    @task.owner = current_user

    if @task.save
      track_activity current_user, @project, @task
      respond_to do |format|
        format.html { redirect_to @project }
        format.json { render json: @project }
        format.js
      end
    else
      flash[:error] = "#{ @project.errors.full_messages.to_sentence }"
      redirect_to teams_path
    end
  end

  def user_team
    if current_team
      @users = current_team.team_member
    end

    respond_to do |format|
      format.json {render json: @users}
    end

  end
  def show
    load_project
    @task = Task.find params[:id]

    respond_to do |format|
      format.js
    end
  end

  def completed
    load_project
    @task = Task.find params[:id]
    if params[:completed] == "true"
      @task.completed_at = Time.now
      @task.save
      track_activity current_user, @task, nil, 'completed'
    elsif params[:completed] == "false"
      @task.completed_at = nil
      Activity.where(subject: @task, action: 'completed').each {|a| a.destroy!}
      @task.save
    end

    respond_to do |format|
      format.js
#      format.html {redirect_to project_path(@project)}
    end
  end

  def owner
    load_project
    @task = Task.find params[:id]
    if params[:owner_id]
      @owner = User.find params[:owner_id]
      @task.owner_id = params[:owner_id]
      @task.save
      track_activity current_user, @task, @owner, 'assign'
    end

    respond_to do |format|
#      format.html {redirect_to project_path(@project)}
      format.js
    end
  end


  def deadline
    load_project
    @task = Task.find params[:id]
    if params[:due_date]
      @task.due_date = params[:due_date]
      #binding.pry
      if @task.save
        flash[:success] = "Change deadline successfully"
      else
        flash[:error] = "Change deadline failed"
      end
    end

    respond_to do |format|
#      format.html {redirect_to project_path(@project)}
      format.js
    end
  end

  def update

  end

  def destroy
    @project = Project.find params[:project_id]
    @task = Task.find params[:id]
    @task.destroy
    redirect_to project_path(@project)
  end
  private
  def task_params
    params.require(:task).permit(:task_id, :name, :description, :position)
  end

  def load_project
    @project = Project.find params[:project_id]
  end
end
