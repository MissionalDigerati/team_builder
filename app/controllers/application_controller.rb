class ApplicationController < ActionController::Base
  protect_from_forgery

  private

    # Used for searchable columns in a verity of controllers / views
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end

    def task_summary
      @tasks_within_week_range = Task.one_week_from_today
      @tasks_this_month = Task.one_month_from_today
      @tasks_overdue = Task.overdue
    end

    def occasion_summary
      today = Date.today
      @occasions_week = Occasion.find_special_dates_for(today, today + 8.days).order('special_date ASC')
    end

end