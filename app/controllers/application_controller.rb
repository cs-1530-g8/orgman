class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper

  # Before Actions #############################################################

  def user_has_position(position)
    unless current_user && !current_user.position.nil? &&
           current_user.position == position
      flash[:notice] = "Sorry but you must be the #{position.name} to view that
                        page"
      redirect_to root_path
    end
  end

  def can_edit_event_type(event_type_id)
    event_type = EventType.find(event_type_id)

    unless current_user && !current_user.position.nil? &&
           (current_user.position.event_type_id == event_type.id ||
            current_user.position == Position.first)
      flash[:notice] = "Sorry! You are not authorized to edit #{event_type.name}
                       events."
      redirect_to root_path
    end
  end

  def can_edit_event(event_id)
    event = Event.find(event_id)
    can_edit_event_type(event.event_type.id)
  end
end
