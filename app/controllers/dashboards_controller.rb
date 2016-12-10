class DashboardsController < ApplicationController
  helper_method :load_project
  def index
    @tasks = current_user.tasks
    @task_news = current_user.activities
    if current_team
      @myProjects = current_team.projects
  #chartjs reporting
      l, t, c = team_report(current_team,  1.days)
      @team_data = make_chart_data(l, t, c)
      @options =  {responsive: true, width: 759, height: 400}
    end

    if current_user
      load_notifications
    end

  end

  def load_project(task)
    @project = Project.find task.project_id
  end

# Report Features

  def team_report(team, interval)

    start_date = team.created_at

    end_date = start_date
    labels = [start_date.strftime("%B %d, %Y")]

    total_task_count = [0]
    completed_task_count = [0]

    begin
      end_date += interval
      labels << end_date.strftime("%B %d, %Y")

      total_count = 0
      completed_count = 0

      team.projects.each do |project|
        tasks = project.tasks.where("created_at < ?", end_date)
        completed_tasks = tasks.where("completed_at < ?", end_date)

        total_count += tasks.count
        completed_count += completed_tasks.count
      end

      total_task_count << total_count
      completed_task_count << completed_count

    end until end_date > Time.now

    return labels, total_task_count, completed_task_count
  end

  def make_chart_data(labels, dataset1, dataset2)
    data = {
      labels: labels,
      datasets: [
        {
          label: "Total tasks",
          backgroundColor: "rgba(220,220,220,0.2)",
          borderColor: "rgba(220,220,220,1)",
          data: dataset1
        },
        {
          label: "Finished tasks",
          backgroundColor: "rgba(151,187,205,0.2)",
          borderColor: "rgba(151,187,205,1)",
          data: dataset2
        }
      ]
    }

    return data
  end

end
