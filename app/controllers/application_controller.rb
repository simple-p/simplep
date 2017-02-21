class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_params, if: :devise_controller?
  before_action :authenticate_user!

  helper_method :current_team
  helper_method :notification_count
  helper_method :notificationBell

  # Search for Ransack
  before_action :build_search

  # Set locale to Vietnamese
  # before_action :set_locale

# Notifications for navbar
  def load_notifications
      # reload user data
      user = User.find current_user.id
      @notifications = user.notifications.order("updated_at DESC")

      new_feeds = user.notification_readers.select {|feed| !feed.isRead?}
      new_feeds.each do |feed|
        feed.read_at = Time.zone.now
        feed.save!
      end
  end

  def set_notifications
    if current_user
      load_notifications

      respond_to {|format| format.js}
    end
  end

  def new_feeds
    @new_feeds = NotificationReader.where(user: current_user, read_at: nil)
    respond_to do |format|
      format.js
    end
  end
# End notification for navbar

  def notification_count
    return NotificationReader.where(user: current_user, read_at: nil).count
  end

  def load_task
    @task = Task.find params[:task_id]
  end

  def current_team
    if current_user.current_team
      Team.find current_user.current_team
    end
  end

  def track_activity(user, subject, trackable, action = params[:action])
    activity = user.activities.new action: action, trackable: trackable, subject: subject
    if action == 'create'
      if subject.class.name == "Project" && trackable.class.name== "Task"
        createProjectNotification(activity)
      end

    end

    if action == 'comment'
      if subject.class.name == "Task" && trackable.class.name== "Comment"
        createTaskChangeNotification(activity)
      end
    end

    if action == 'assign'
      if subject.class.name == "Task" && trackable.class.name== "User"
        createAssignTaskNotification(activity)
      end
    end

    if action == 'completed'
      if subject.class.name == "Task"
        createTaskChangeNotification(activity)
      end
    end
  end

  def createAssignTaskNotification(activity)
    notification = Notification.create! news_type: "assign_change"

    notification.notification_readers.find_or_create_by! user: activity.trackable
    notification.notification_readers.find_or_create_by! user: activity.subject.owner

    activity.notification_id = notification.id
    activity.save!

    return notification.id
  end

  def createTaskChangeNotification(activity)
    task_detail_activity = Activity.where(subject: activity.subject, action:['completed', 'comment']).first
    if task_detail_activity
      notification = task_detail_activity.notification

      activity.subject.followers.each do |follower|
        notification.notification_readers.find_or_create_by! user: follower
      end

      notification.notification_readers.each do |feed|
        feed.read_at = nil
        feed.save!
      end
    else
      notification = Notification.create! news_type: "task_detail_change"

      activity.subject.followers.each do |follower|
        notification.notification_readers.find_or_create_by! user: follower
      end
    end

    notification.updated_at = Time.zone.now
    notification.save!

    activity.notification_id = notification.id
    activity.save!

    return notification.id

  end

  def createProjectNotification(activity)
    last_activitiy = Activity.where(subject: activity.subject, action: 'create', trackable_type: 'Task').last
    notification_count = 0
    if last_activitiy && last_activitiy.notification_id != nil
      notification_count = Activity.where(notification_id: last_activitiy.notification_id).count
    end

    if notification_count.between?(1,4)
      activity.notification_id = last_activitiy.notification_id
      activity.save!

      notification = Notification.find(activity.notification_id)
      notification.updated_at = Time.zone.now
      notification.notification_readers.each do |feed|
        feed.read_at = nil
        feed.save!
      end
      notification.save!
    else
      notificationProject(activity)
    end
  end

  def notificationProject(activity)
    notification = Notification.create! news_type: "project_list"

    activity.subject.team.team_member.each do |member|
      notification.notification_readers.find_or_create_by! user: member
    end

    activity.notification_id = notification.id
    activity.save!

    return notification.id
  end

# Define set locale for I18n
  # def set_locale
  #   I18n.locale = params[:locale] || I18n.default_locale
  # end

  private
    def build_search
      @search = Task.search(params[:q])
    end

  protected

  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :password_confirmation, :avatar, :current_team])
  end
end
