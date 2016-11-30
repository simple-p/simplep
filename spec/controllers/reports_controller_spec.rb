require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  describe "Report completed tasks" do

    before(:each) do
#      @user = User.create! name: "ZZ", email: "z@example.com", password: "123456"
#      @user2 = User.create! name: "YYlllll", email: "y@example.com", password: "123456"
      @team = Team.create! name: "TeamAA"
#      @team.memberships.create! member: @user2

#      @projectA = @team.projects.create! name: "ProjectA", create_at: 
#      @projectB = @team.projects.create! name: "ProjectA"
#
#      @task = @project.tasks.create! name: "TaskA"
    end

    it "return at least 2 elements" do
      projectA = @team.projects.create! name: "ProjectA"
      task = projectA.tasks.create! name: "TaskA"
      labels, total, completed = ReportsController.new.project_report(projectA, 1.days)

      expect(labels.count).to be >= 2
      expect(total.count).to be >= 2
      expect(completed.count).to be >= 2
    end
    
    it "1 task but not completed" do
      projectA = @team.projects.create! name: "ProjectA", created_at: 7.days.ago
      task = projectA.tasks.create! name: "TaskA", created_at: 6.days.ago
      labels, total, completed = ReportsController.new.project_report(projectA, 3.days)

      expect(labels.count).to be >= 4
      expect(total.count).to be >= 4
      expect(completed.count).to be >= 4

      expect(total).to be == [0,1,1,1] 
      expect(completed).to be == [0,0,0,0] 

    end
    
    it "many completed task" do
      projectA = @team.projects.create! name: "ProjectA", created_at: 7.days.ago
      task = projectA.tasks.create! name: "TaskA", created_at: 6.days.ago, completed_at: 5.days.ago
      
      task = projectA.tasks.create! name: "TaskA", created_at: 3.days.ago, completed_at: 11.hours.ago
      labels, total, completed = ReportsController.new.project_report(projectA, 3.days)

      expect(labels.count).to be >= 4
      expect(total.count).to be >= 4
      expect(completed.count).to be >= 4

      expect(labels).to be == []
      expect(total).to be == [0,1,2,2] 
      expect(completed).to be == [0,0,0,0] 
    end
  end
end
