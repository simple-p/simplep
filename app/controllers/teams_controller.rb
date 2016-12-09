class TeamsController < ApplicationController
  before_action :load_team, only: [:show, :update, :destroy]
  def index
    @teams = current_user.my_team
  end

  def new
    # load_project
    @team = Team.new
  end

  def create
    # @team = @project.teams.build team_params
    @team = Team.create team_params
    if @team.save
      current_user.set_current_team(@team.id)
      respond_to do |format|
        format.html { redirect_to teams_path }
        format.json { render json: @team }
        format.js
      end
    else
      flash[:error] = "#{ @team.errors.full_messages.to_sentence }"
      redirect_to teams_path
    end
  end

  def show
    @members = @team.memberships
  end

  def update
    # load_project
    respond_to do |format|
      if @team.update team_params
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @team.errors.full_messages,
                      status: :unprocessable_entity }
      end
    end
  end

  def switch
    current_user.set_current_team(params[:team_id])
    redirect_to teams_path
  end

  def destroy
    # load_project
    if @team.is_default?
      flash[:notice] = "Can't delete default team"
      redirect_to teams_path
    else
      respond_to do |format|
        current_user.destroy_current_team
        @team.destroy
        format.html { redirect_to teams_path }
        format.json { head :no_content }
      end
    end

  end

  private

  def load_team
    @team = Team.find params[:id]
  end

  def team_params
    params.require(:team).permit(:name, :owner_id, :team_id)
  end
end
