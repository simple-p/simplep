class Task < ApplicationRecord
  belongs_to :project
  has_many :task_followers
  has_many :followers, :through => :task_followers, :source => :user
end
