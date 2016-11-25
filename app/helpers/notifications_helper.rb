module NotificationsHelper
  def renderNotifications(notifications)
    notifications.each do |notification|
      if notification.activities.count > 0
        case 
        when notification.news_type == 'task_detail_change' then 
          render 'notifications/task_detail'

        when notification.news_type == 'assign_change' then 
          render 'notifications/assign'

        when notification.news_type == 'project_list' then 
          render 'notifications/project_news'
        end
      end
    end
  end
end
