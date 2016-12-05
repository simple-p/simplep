class Project < ApplicationRecord
  validates :name, presence: true
  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy
  belongs_to :team, optional: true
  has_many :blogs, dependent: :destroy
end
