class NotificationsController < ApplicationController
  def index
    if current_user
      # reload user data
      user = User.find current_user.id
      @notifications = user.notifications 
    end
  end
end
