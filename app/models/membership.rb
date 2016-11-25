class Membership < ApplicationRecord
  belongs_to :member, class_name: 'User'
  belongs_to :team
  validates :team_id, presence: true

end
