class NotificationReader < ApplicationRecord
  belongs_to :notification
  belongs_to :user

  def isRead?
    !!read_at
  end
end
