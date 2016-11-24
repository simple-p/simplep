class BlogsController < ApplicationController
  def index
    load_project
    @blog = @project.blogs.order("created_at DESC")
  end

  def show
  end

  def new
    load_project
    @blog = Blog.new
  end

  def create
    load_project
    @blog = @project.blogs.build blog_params
    @blog.user = current_user

    if @blog.save
      track_activity @project, @blog
      redirect_to project_path(@project)
    else
      flash[:error] = 'Name must be 5 character minimum'
      redirect_to new_project_blog_path(@project)
    end
  end

  def load_project
    @project = Project.find params[:project_id]
  end

  def blog_params
    params.require(:blog).permit(:status,:title,:content)
  end
end
