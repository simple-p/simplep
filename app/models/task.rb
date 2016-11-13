class Task < ApplicationRecord
  belongs_to :project
  has_many :task_followers, dependent: destroy
  has_many :followers, :through => :task_followers, :source => :user
  has_many :comments, dependent: destroy
end
