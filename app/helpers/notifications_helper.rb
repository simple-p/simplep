module NotificationsHelper
  def renderNotification(notification, compact=false)
    case 
    when notification.news_type == 'task_detail_change' then 
      render partial: 'notifications/task_detail', locals: {notification: notification, compact:compact}

    when notification.news_type == 'assign_change' then 
      render partial: 'notifications/assign', locals: {notification: notification, compact:compact }

    when notification.news_type == 'project_list' then 
      render partial: 'notifications/project_news', locals: {notification: notification, compact:compact}

    end
  end
end
