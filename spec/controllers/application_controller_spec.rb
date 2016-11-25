require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe "Notification helper" do
    before(:each) do
      @user = User.create! name: "ZZ", email: "z@example.com", password: "123456"
      @user2 = User.create! name: "YYlllll", email: "y@example.com", password: "123456"
      @team = Team.create! name: "TeamAA"
      @team.memberships.create! member: @user2

      @project = @team.projects.create! name: "ProjectA"
      @task = @project.tasks.create! name: "TaskA"

    end
    it "Create new task notification" do
      activity = @user.activities.create! subject: @project, trackable: @task, action: 'create'
      new_id = ApplicationController.new.notificationProject(activity)
      expect(activity.notification_id).to eq(new_id)
      expect(Notification.all.count).to eq(1)
      expect(NotificationReader.all.count).to eq(2)
    end

    it "Create multi task" do
      activity = @user.activities.create! subject: @project, trackable: @task, action: 'create'
      new_id = ApplicationController.new.notificationProject(activity)
      taskB = @project.tasks.create! name: "TaskB"
      activityB = @user.activities.build subject: @project, trackable: taskB, action: 'create'
      ApplicationController.new.createProjectNotification(activityB)

      expect(Activity.where(notification_id: new_id).count).to eq(2)
      expect(Notification.all.count).to eq(1)
      expect(NotificationReader.all.count).to eq(2)
    end

    it "track_activity for new task" do
      taskB = @project.tasks.create! name: "TaskB"
      ApplicationController.new.track_activity(@user, @project, taskB, 'create')
      expect(Activity.where(subject: @project, trackable: taskB, action: 'create').count).to eq(1)
      expect(Notification.all.count).to eq(1)
      expect(NotificationReader.all.count).to eq(2)
    end

    it "createAssignTaskNotification" do
      @task.owner = @user2
      activity = @user.activities.new subject: @task, trackable: @user, action: 'assign'
      ApplicationController.new.createAssignTaskNotification(activity)
            
      expect(Activity.where(subject: @task, trackable: @user, action: 'assign').count).to eq(1)
      expect(Notification.all.count).to eq(1)
      expect(NotificationReader.all.count).to eq(2)
    end
  end
end
