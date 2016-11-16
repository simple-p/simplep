class Activity < ApplicationRecord
	belongs_to :user
	belongs_to :trackable, polymorphic: true
	belongs_to :subject, polymorphic: true
end
