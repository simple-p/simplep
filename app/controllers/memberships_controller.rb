class MembershipsController < ApplicationController

  def create
    @team = Team.find(params[:team_id])
    @member = User.find_by_email params[:email]
    if @member.nil?
      flash[:notice] = "email was wrong or doesn't existed."
      redirect_to @team
    elsif @team.owner == @member
      flash[:notice] = "You are owner"
      redirect_to @team
    elsif @member.is_member?(@team.id)
      flash[:notice] = "#{@member.email} is already member"
      redirect_to @team
    else
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
    end
  end

  def destroy
    @member = User.find_by_email(params[:email])
    @membership = Membership.find params(member_id: @member.id, team_id: current_team.id)
    if @membership.destroy
      respond_to do |format|
        format.html { redirect_to projects_path }
        format.json { head :no_content }
      end
    else
      flash[:error] = "@membership.errors.full_messages.to_sentence"
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:member_id)
  end
end
