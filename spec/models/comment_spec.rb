require 'rails_helper'

RSpec.describe Comment, type: :model do
    before(:each) do
      @user = User.create! name: "ZZ", email: "z@example.com", password: "123456"
      @user2 = User.create! name: "YYlllll", email: "y@example.com", password: "123456"
      @team = Team.create! name: "TeamAA"
      @team.memberships.create! member: @user2

      @project = @team.projects.create! name: "ProjectA"
      @task = @project.tasks.create! name: "TaskA"
    end

    it "delete activity after delete comment" do

      comment = @task.comments.create! content: 'New comment', user: @user
      @task.task_followers.create! user: @user

      ApplicationController.new.track_activity(@user, @task, comment , 'comment')
      expect(Activity.where(subject: @task, trackable: comment, action: 'comment').count).to eq(1)
      expect(Notification.all.count).to eq(1)
      expect(NotificationReader.all.count).to eq(1)

      comment.destroy!
      
      expect(Activity.where(subject: @task, trackable: comment, action: 'comment').count).to eq(0)
      expect(Notification.all.count).to eq(1)
      expect(NotificationReader.all.count).to eq(1)
    end
    
end
