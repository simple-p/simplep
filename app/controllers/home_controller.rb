class HomeController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index]
	def index
		if current_user
			redirect_to dashboard_path
		end
	end
end
