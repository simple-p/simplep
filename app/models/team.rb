class Team < ApplicationRecord
	belongs_to :owner, class_name: 'User'
	has_many :memberships
	has_many :members, through: :memberships, :source => :user
	has_many :projects, dependent: :destroy
end
