class TeamsController < ApplicationController

	def new
		@team = Team.new
	end

	def create
		@team = Team.new team_params
		@team.owner = current_user
		if @team.save
			respond_to do |format|
				format.html { redirect_to dashboard_path }
				format.json { render json: @team }
			end
		else
			redirect_to new_team_path
		end
	end

	def show
		@team = Team.find(params[:id])
		@members = @team.memberships
	end

	private

	def team_params
		params.require(:team).permit(:name, :user_id, :email)
	end
end
