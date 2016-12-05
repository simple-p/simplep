class User < ApplicationRecord
  require 'identicon'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :tasks, foreign_key: 'owner_id'
  has_many :activities, dependent: :destroy
  has_many :task_followers, class_name: 'TaskFollower', dependent: :destroy
  has_many :following_tasks, :through => :task_followers, :source => :task
  has_many :memberships
  has_many :teams, through: :memberships, :source => :member
  has_many :notification_readers, dependent: :destroy
  has_many :notifications, :through => :notification_readers, :source => :notification

  # add avatar attachment
  attr_reader :default_avatar
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  def is_member?(team_id)
    Membership.where(team_id: team_id, member_id: id).take
  end

  def default_avatar
    self.avatar = URI.parse("https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}").open
    @default_avatar = "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}"
    save!
  end

  def my_team
    # Membership.where(member_id: id)
    @my_team = []
    Team.where(owner_id: id).each { |team| @my_team << team }
    Membership.where(member_id: id).each do |membership|
      @my_team << membership.team
    end
    @my_team
  end

  def set_current_team(team_id)
    self.current_team = team_id
    save
  end

  def destroy_current_team
    @my_team = my_team
    if @my_team == []
      self.current_team = nil
    else
      team = @my_team.first
      self.current_team = team.id
    end
    save!
  end
end
