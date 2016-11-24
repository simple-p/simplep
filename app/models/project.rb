class Project < ApplicationRecord
	has_many :tasks
	has_many :blogs, dependent: :destroy
	belongs_to :team, optional: true
end
