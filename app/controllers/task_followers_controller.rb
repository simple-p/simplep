class TaskFollowersController < ApplicationController
  def create
   load_task
   @task_follower = @task.task_followers.build task_follower_params
   if @task_follower.save
      respond_to do |format|
        format.html do
          if @task_follower.persisted?
            redirect_to tasks_path, flash: {success: "follower added"}
          else
            redirect_to tasks_path, flash: {alert: "Failed to add follower"}
          end
        end

        format.js
     end
   end    
  end

  def destroy
    load_task
    @task_follower = TaskFollower.find params[:id]
    @task_follower.destroy

    respond_to {|format| format.js}

  end
  private
  def task_follower_params
    params.require(:task_follower).permit(:user_id)
  end
end
