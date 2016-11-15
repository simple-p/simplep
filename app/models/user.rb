class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :activities
  has_many :task_followers, class_name: 'TaskFollower'
  has_many :following_tasks, :through => :task_followers, :source => :task 
  has_many :task_news, :through => :following_tasks, :source => :activities
  has_many :memberships
  has_many :teams, through: :memberships

end
