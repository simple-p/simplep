class TeamsController < ApplicationController

	def new
		# load_project
		@team = Team.new
	end

	def create
	# @team = @project.teams.build team_params
		@team = Team.create team_params
		@team.owner = current_user
		@team.project_id = nil
		if @team.persisted?
			respond_to do |format|
				format.html { redirect_to root_path }
				format.json { render json: @team }
			end
		else
			# redirect_to new_projects_team_path(@project)
			redirect_to new_team_path
		end
	end

	def show
		load_team
		@members = @team.memberships
	end

	def update
		# load_project
		load_team
		respond_to do |format|
			format.html do
				@team.update team_params
			end
			format.json { render json: @team }
		end
	end

	def destroy
		# load_project
		load_team
		@team.destroy
		redirect_to project_path(@project)
	end

	private

	def load_project
		@project = Project.find params[:project_id]
	end

	def load_team
		@team = Team.find params[:id]
	end

	def team_params
		params.require(:team).permit(:name, :user_id, :email)
	end
end
