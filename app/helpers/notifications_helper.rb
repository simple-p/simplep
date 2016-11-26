module NotificationsHelper
  def renderNotification(notification)
    case 
    when notification.news_type == 'task_detail_change' then 
      render partial: 'notifications/task_detail', locals: {notification: notification}

    when notification.news_type == 'assign_change' then 
      render partial: 'notifications/assign', locals: {notification: notification}

    when notification.news_type == 'project_list' then 
      render partial: 'notifications/project_news', locals: {notification: notification}

    end
  end
end
