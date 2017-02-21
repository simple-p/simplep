class Task < ApplicationRecord

  default_scope { order("position ASC") }

  belongs_to :project
  belongs_to :user, optional: true
  belongs_to :owner, class_name: 'User'
  has_many :task_followers, dependent: :destroy
  has_many :followers, :through => :task_followers, :source => :user
  has_many :comments, dependent: :destroy
  has_many :activities, as: :subject, dependent: :destroy
  has_one :project_news, class_name: 'Activity', as: :trackable, dependent: :destroy

  validates :name, presence: true

  def isCompleted?
    !!completed_at
  end

  def followers
    @followers = []
    @task_followers = TaskFollower.where(task_id: id)
    @task_followers.each do |task_follower|
      @followers << task_follower.user
    end
    @followers
  end
end
