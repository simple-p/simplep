class AddNotificationToActivity < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :notification_id, :integer
  end
end
