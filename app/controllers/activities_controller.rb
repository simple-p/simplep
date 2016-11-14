class ActivitiesController < ApplicationController
  def index
    if current_user
      @task_news = current_user.task_news 

    end

  end
end
