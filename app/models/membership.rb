class Membership < ApplicationRecord
  belongs_to :member, class_name: 'User'
  belongs_to :team
  validates :team_id, presence: true

  def self.has_memberships?(member_id, team_id)
    Membership.where(member_id: member_id, team_id: team_id).take
  end
end
