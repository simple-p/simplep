class TeamsController < ApplicationController

	def new
		@team = Team.new
	end

	def create
		@team = Team.new team_params
		@team.owner = current_user
		if @team.save
			respond_to do |format|
				format.html { redirect_to root_path }
				format.json { render json: @team }
			end
		else
			redirect_to new_team_path
		end
	end

	def show
		load_team
		@members = @team.memberships
	end

	def update
		load_team
		respond_to do |format|
			format.html do
				@team.update team_params
			end
			format.json { render json: @team }
		end
	end

	private

	def load_team
		@team = Team.find params[:id]
	end

	def team_params
		params.require(:team).permit(:name, :user_id, :email)
	end

end
