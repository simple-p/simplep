class ActivitiesController < ApplicationController
  def index
    if current_user
      @task_news = current_user.activities 

    end

  end
end
