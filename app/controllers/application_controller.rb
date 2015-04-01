class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper

  # Before Actions #############################################################

  def user_has_position(position_string)
    unless current_user.has_position(position_string)
      flash[:notice] = "Sorry but you must be the #{position_string} to view that
                        page"
      redirect_to root_path
    end
  end

  def can_edit_event_type(event_type_id)
    event_type = EventType.find(event_type_id)
    unless current_user.position.present? &&
           (current_user.position.event_type_id == event_type.id ||
            current_user.has_position(User::SECRETARY))
      flash[:notice] = "Sorry! You are not authorized to edit #{event_type.name}
                       events."
      redirect_to root_path
    end
  end

  def can_edit_event(event_id)
    event = Event.find(event_id)
    can_edit_event_type(event.event_type.id)
  end

  def can_create_events
    if current_user.position.nil?
      flash[:alert] = "You must be a chairman or the secretary to add an event"
      redirect_to events_path
    end
  end
end
