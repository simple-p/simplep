class User < ApplicationRecord
	has_many :memberships
	has_many :teams, through: :memberships

	# accepts_nested_atrributes_for :memberships, :teams
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable

end
