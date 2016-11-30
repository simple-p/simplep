class ReportsController < ApplicationController
  def index
    if current_team
      @project_data = {} 
        current_team.projects.each do |p|
          l, t, c = project_report(p, 1.days)
          d = make_chart_data(l, t, c)
          @project_data[p.name.to_sym] = d
        end
          
       l, t, c = team_report(current_team,  1.days)
       @team_data = make_chart_data(l, t, c)
    end
    @options =  {responsive: true}
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

  def project_report(project, interval)

    start_date = project.created_at

    end_date = start_date 
    labels = [start_date.strftime("%B %d, %Y")]

    total_task_count = [0]
    completed_task_count = [0]

    begin 
      end_date += interval
      labels << end_date.strftime("%B %d, %Y")
      tasks = project.tasks.where("created_at < ?", end_date)
      completed_tasks = tasks.where("completed_at < ?", end_date)
      total_task_count << tasks.count
      completed_task_count << completed_tasks.count 

    end until end_date > Time.now 

    return labels, total_task_count, completed_task_count
  end

end
