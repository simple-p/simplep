class AddSeenAtToNotificationReader < ActiveRecord::Migration[5.0]
  def change
    add_column :notification_readers, :read_at, :datetime
  end
end
