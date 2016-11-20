class Project < ApplicationRecord
	has_many :tasks
	belongs_to :team, optional: true
end
