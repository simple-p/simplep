class CommentsController < ApplicationController
  def new 
    load_task
    @task = Task.new
  end

  def index
    load_task
    @comments = @task.comments
  end

  def create
    load_task
    @comment = @task.comments.build comment_params
    
    if @comment.save
      redirect_to root_path 
    else
      redirect_to new_tasks_comment_path(@task) 
    end

  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

  def load_task
    @task = Task.find params[:task_id]
  end
end
