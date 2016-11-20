class TeamsController < ApplicationController
    def index
      @teams = Team.all
    end

  def new
    # load_project
    @team = Team.new
  end

  def create
    # @team = @project.teams.build team_params
    @team = Team.create team_params
    if @team.save
      respond_to do |format|
        format.html { redirect_to teams_path }
        format.json { render json: @team }
        format.js
      end
    else
      flash[:error] = "#{ @team.errors.full_messages.to_sentence }"
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
      if @team.update team_params
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @team.errors.full_messages,
                      status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # load_project
    load_team
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_path }
      format.json { head :no_content }
    end
  end

  private

  def load_team
    @team = Team.find params[:id]
  end

  def team_params
    params.require(:team).permit(:name, :owner_id)
  end
end
