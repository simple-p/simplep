class ProjectsController < ApplicationController
	def index
		@project = Project.all.order("created_at DESC")
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.new project_params
		respond_to do |format|
			if @project.save
				format.html { redirect_to root_path }
				format.json { head :no_content }
				format.js
			else
				format.json { render json:@project.errors.full_messages,
															status: :unprocessable_entity }
			end
		end
	end

	def edit
		set_project
	end

	def show
		set_project
	end

	def update
		set_project
		respond_to do |format|
			if @project.update project_params
				format.html { redirect_to project_path }
				format.json { head :no_content }
				format.js
			else
				format.json { render json: @project.errors.full_messages,
															status: :unprocessable_entity }
			end
		end
	end

	def destroy
		set_project
		@project.destroy
		respond_to do |format|
			format.html { redirect_to project_path }
			format.json { head :no_content }
			format.js
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
