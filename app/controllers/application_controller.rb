class ApplicationController < ActionController::Base
  protect_from_forgery

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end
  
end
