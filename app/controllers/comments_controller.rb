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
    @comment = @task.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      track_activity current_user, @task, @comment, 'comment'
      respond_to do |format|
        format.html do
          if @comment.persisted?
            redirect_to tasks_path, flash: {success: "Comment added"}
          else
            redirect_to tasks_path, flash: {alert: "Failed to add comments"}
          end
        end

        format.js
      end
    end
  end

  def show

  end

  def update

  end

  def destroy
    load_task
    @comment = Comment.find params[:id]

    @comment.destroy
    respond_to do |format|
      format.js
    end

  end
  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end
