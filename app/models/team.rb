class Team < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sentitive: true }
  belongs_to :owner, class_name: 'User'
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, :source => :member
  has_many :projects, dependent: :destroy

  def team_member
    @team_member = []
    if owner
      @team_member << owner
    end
    Membership.where(team_id: id).each do |membership|
      @team_member << membership.member
    end
    @team_member
  end

  def other_member
    team_member - current_user
  end

  def my_team_project
    Project.where(team_id: id)
  end

  def is_default?
    @default_team = Team.find_by_name("#{self.owner.name} Team")
    true if @default_team == self
  end
end
