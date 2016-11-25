class CreateNotificationReaders < ActiveRecord::Migration[5.0]
  def change
    create_table :notification_readers do |t|
      t.references :notification, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
