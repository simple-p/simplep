class BlogsController < ApplicationController
  def index
    load_project
    @blog = @project.blogs.order("created_at DESC")
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def edit
    load_project
    @blog = Blog.find(params[:id])
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
      redirect_to project_blogs_path(@project)
    else
      flash[:error] = 'Name must be 5 character minimum'
      redirect_to new_project_blog_path(@project)
    end
  end

  def update
    load_project
    @blog = Blog.find(params[:id])

    if @blog.update(blog_params)
      redirect_to project_blogs_path(@project)
    else
      render 'edit'
    end
  end

  def destroy
    load_project
    @blog = Blog.find(params[:id])
    @blog.destroy

    redirect_to project_blogs_path(@project)
  end


  def load_project
    @project = Project.find params[:project_id]
  end

private
  def blog_params
    params.require(:blog).permit(:status,:title,:content)
  end
end
