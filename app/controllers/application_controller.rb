class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	before_action :configure_permitted_params, if: :devise_controller?
	before_action :authenticate_user!

	def track_activity(subject, trackable, action = params[:action])
		current_user.activities.create! action: action, trackable: trackable, subject: subject
	end
	def load_task
		@task = Task.find params[:task_id]
	end

	protected

	def configure_permitted_params
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
	end
end
