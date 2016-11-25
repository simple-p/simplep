class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_params, if: :devise_controller?
  before_action :authenticate_user!

  helper_method :current_team

  def load_task
    @task = Task.find params[:task_id]
  end

  def current_team
    if current_user.current_team
      Team.find current_user.current_team
    end
  end

  def track_activity(subject, trackable, action = params[:action])
    current_user.activities.create! action: action, trackable: trackable, subject: subject
  end

  protected

  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :password_confirmation, :avatar, :current_team])
  end
end
