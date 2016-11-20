class Project < ApplicationRecord
	has_many :tasks
	belongs_to :team
end
