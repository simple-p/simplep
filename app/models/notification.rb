class Notification < ApplicationRecord
  has_many :notification_readers
  has_many :readers, :through => :notification_readers, :source => :user
  has_many :activities
end
