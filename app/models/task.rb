class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true
  belongs_to :owner, class_name: 'User'
  has_many :task_followers, dependent: :destroy
  has_many :followers, :through => :task_followers, :source => :user
  has_many :comments, dependent: :destroy
  has_many :activities, as: :subject, dependent: :destroy

  def isCompleted?
    !!completed_at
  end
end
