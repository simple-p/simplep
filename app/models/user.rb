class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable

	has_many :activities, dependent: :destroy
	has_many :task_followers, class_name: 'TaskFollower', dependent: :destroy
	has_many :following_tasks, :through => :task_followers, :source => :task
	has_many :task_news, :through => :following_tasks, :source => :activities
	has_many :memberships, dependent: :destroy
	has_many :teams, through: :memberships

	def is_member?(team_id)
		Membership.where(team_id: team_id, member_id: id).take
	end
end
