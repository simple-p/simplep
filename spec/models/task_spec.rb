require 'rails_helper'

RSpec.describe Task, type: :model do
    before(:each) do
      @user = User.create! name: "ZZ", email: "z@example.com", password: "123456"
      @user2 = User.create! name: "YYlllll", email: "y@example.com", password: "123456"
      @team = Team.create! name: "TeamAA"
      @team.memberships.create! member: @user2

      @project = @team.projects.create! name: "ProjectA"
    end

    it "delete activity from project acitivity list" do
      taskB = @project.tasks.create! name: "TaskB"
      ApplicationController.new.track_activity(@user, @project, taskB, 'create')
      expect(Activity.where(subject: @project, trackable: taskB, action: 'create').count).to eq(1)
      expect(Notification.all.count).to eq(1)
      expect(NotificationReader.all.count).to eq(2)

      task = Task.find taskB.id
      expect(task.activities.size).to eq(0)
      expect(task.project_news.trackable).to eq(task)

      task.destroy!
      
      expect(Activity.where(subject: @project, trackable: taskB, action: 'create').count).to eq(0)
      expect(Notification.all.count).to eq(1)
      expect(NotificationReader.all.count).to eq(2)
    end

    it "Task comment Notification" do
      taskB = @project.tasks.create! name: "TaskB"
      comment = taskB.comments.create! content: 'New comment', user: @user
      taskB.task_followers.create! user: @user
      activity = @user.activities.new subject: taskB, trackable: comment, action: 'comment'
      ApplicationController.new.createTaskChangeNotification(activity)
            
      expect(Activity.where(subject: taskB, trackable: comment, action: 'comment').count).to eq(1)
      expect(Notification.all.count).to eq(1)
      expect(NotificationReader.all.count).to eq(1)

      task = Task.find taskB.id
      expect(task.activities.size).to eq(1)

      task.destroy!
      
      expect(Activity.where(subject: @project, trackable: taskB, action: 'create').count).to eq(0)
      expect(Notification.all.count).to eq(1)
      expect(NotificationReader.all.count).to eq(1)
    end
end
