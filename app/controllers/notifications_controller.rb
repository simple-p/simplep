class NotificationsController < ApplicationController
  #
  # No need to implement the notification controller as it's in the application controller already
  #
  # def index
  #   if current_user
  #     # reload user data
  #     user = User.find current_user.id
  #     @notifications = user.notifications.order("updated_at DESC")
  #
  #     new_feeds = user.notification_readers.select {|feed| !feed.isRead?}
  #     new_feeds.each do |feed|
  #       feed.read_at = Time.now
  #       feed.save!
  #     end
  #   end
  # end
  #
  #
# def new_feeds
#   @new_feeds = NotificationReader.where(user: current_user, read_at: nil)
#   respond_to do |format|
#     format.js
#   end
# end
end
