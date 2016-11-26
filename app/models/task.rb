class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true
  belongs_to :owner, class_name: 'User'
  has_many :task_followers, dependent: :destroy
  has_many :followers, :through => :task_followers, :source => :user
  has_many :comments, dependent: :destroy
  has_many :activities, as: :subject, dependent: :destroy
  has_one :project_news, class_name: 'Activity', as: :trackable, dependent: :destroy

  validates :name, presence: true,
                    length: { minimum: 5 }
  def isCompleted?
    !!completed_at
  end
end
