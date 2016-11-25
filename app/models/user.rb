class User < ApplicationRecord
	require 'identicon'
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable

        has_many :tasks, foreign_key: 'owner_id'
	has_many :activities, dependent: :destroy
	has_many :task_followers, class_name: 'TaskFollower', dependent: :destroy
	has_many :following_tasks, :through => :task_followers, :source => :task
	has_many :task_news, :through => :following_tasks, :source => :activities
	has_many :memberships, dependent: :destroy
	has_many :teams, through: :memberships

	# add avatar attachment
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

	def is_member?(team_id)
		Membership.where(team_id: team_id, member_id: id).take
	end

	def default_avatar
		"https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}"
	end

	def my_team
		Membership.where(:member_id => id)
	end
end
