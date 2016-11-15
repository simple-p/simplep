class MembershipsController < ApplicationController

	def create
		@team = Team.find(params[:team_id])
		@member = User.find_by_email params[:email]
		if @team.owner != @member
			@membership = Membership.new(:member_id => @member.id, :team_id => @team.id)
			if @membership.save
				respond_to do |format|
					format.html do
						if @membership.persisted?
							redirect_to @team, flash: {success: "add member success"}
						else
							redirect_to @team, flash: {notice: "cannot add member"}
						end
					end
					format.json { render json: @membership }
				end
			end
		else
			flash[:notice] = "You are owner"
		end
	end

	private

	def membership_params
		params.require(:membership).permit(:member_id)
	end
end
