class Project < ApplicationRecord
	has_many :tasks
	has_many :teams
end
