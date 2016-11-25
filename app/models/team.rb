class Team < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sentitive: true }
  belongs_to :owner, class_name: 'User'
  has_many :memberships
  has_many :members, through: :memberships, :source => :member
  has_many :projects, dependent: :destroy

  def team_member
    @team_member = []
    @team_member << owner
    Membership.where(team_id: id).each do |membership|
      @team_member << membership.member
    end
    @team_member
  end

  def other_member
    team_member - [current_user]
  end

  def my_team_project
    Project.where(team_id: id)
  end
end
