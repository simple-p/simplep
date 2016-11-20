class HomeController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index]
	def index
		if current_user
			redirect_to projects_path
		end
	end
	def dashboard
		@teams = Team.all
	end
end
