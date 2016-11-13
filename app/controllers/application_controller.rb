class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def track_activity(subject, trackable, action = params[:action])
    current_user.activities.create! action: action, trackable: trackable, subject: subject
  end
end
