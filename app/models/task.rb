class Task < ApplicationRecord
  belongs_to :project
  belongs_to :owner, class_name: 'User'
  has_many :task_followers
  has_many :followers, :through => :task_followers, :source => :user
  has_many :comments
  has_many :activities, as: :trackable
end
