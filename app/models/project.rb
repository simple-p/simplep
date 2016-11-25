class Project < ApplicationRecord
  validates :name, presence: true
  has_many :tasks
  belongs_to :team, optional: true
  has_many :blogs
end
