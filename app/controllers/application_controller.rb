class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper

  def user_has_position(position)
    unless current_user && current_user.position == position
      flash[:notice] = "Sorry but you must be the #{position} to view that page"
      redirect_to root_path
    end
  end
end
