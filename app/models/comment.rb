class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :task
  has_many :activities, as: :trackable, dependent: :destroy
end
